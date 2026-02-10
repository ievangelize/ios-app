// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:deepgram_speech_to_text/deepgram_speech_to_text.dart';
import 'package:openai_tts/openai_tts.dart';
import 'package:audio_session/audio_session.dart';

/// Deepgram STT widget integrated with streamTTS
class DeepgramSTT extends StatefulWidget {
  const DeepgramSTT({
    super.key,
    this.width,
    this.height,
    required this.deepgramApiKey,
    required this.chatCompletion,
    required this.apiKey,
    required this.fontSize,
    required this.fontColor,
  });

  final double? width;
  final double? height;
  final String deepgramApiKey;
  final Future<dynamic> Function(String words) chatCompletion;
  final String apiKey;
  final double fontSize;
  final Color fontColor;

  @override
  State<DeepgramSTT> createState() => _DeepgramSTTState();
}

class _DeepgramSTTState extends State<DeepgramSTT> {
  FlutterSoundRecorder? _recorder;
  OpenaiTTS? _activeTTS;
  // controller that ultimately feeds Deepgram
  StreamController<Uint8List>? _audioController;

  // forwarding controller: mic -> forwardingController -> optionally -> _audioController
  StreamController<Uint8List>? _forwardingController;

  StreamSubscription? _sttSubscription;
  late Deepgram _deepgram;

  String _transcript = "";
  String _statusText = "Idle";

  bool _isFirstTurn = true;
  bool _isRecording = false;
  bool _isStreaming = true; // when false, we don't forward mic -> Deepgram
  bool _isTTSPlaying = false; // Track TTS state
  bool _gotFirstTranscript = false; // getting first transcript
  DateTime? _recordStartTime;
  DateTime? _lastVoiceActivity; // Track when we last detected voice activity

  // VAD / silence support
  int _silentFrameCount = 0;
  final int _silentFrameThreshold =
      15; // ~15 frames * ~20ms ≈ 300ms of continuous silence
  // If your buffer size / sample rate changes, you can tune this number.
  // Using 15 works for your 960-byte buffer @24kHz (~20ms/frame => 15*20ms=300ms)

  Timer? _silenceTimer;
  static const int _silenceThreshold =
      800; // ms of VOICE inactivity = end of turn
  static const int _minRecordingMs =
      100; // minimum time to allow before ending turn

  // VAD parameters
  static const double _voiceRmsThreshold = 0.08; // normalized RMS threshold

  // --- VAD / decibel (RecordingDisposition) fields ---
  StreamSubscription<RecordingDisposition>? _recorderProgressSub;

// EMA smoothing for decibels (dB)
  double _emaDb = 0.0; // initial very quiet baseline (dB)
  final double _emaAlpha =
      0.2; // smoothing factor (0 < alpha <= 1). Increase alpha → more responsive

// Hysteresis thresholds (in dB). Tune these per device/env.
  double _speechOnDb =
      40.0; // go into "speech" state when EMA > this (example -28 dB)
  double _speechOffDb =
      27.0; // go into "silent" only when EMA < this (example -38 dB)

// Hangover / sustained silence window (ms)
  int _hangoverMs =
      800; // require ~350ms of continuous quiet before we treat as silence

// Tracking quiet window start time
  DateTime? _quietStartTime;
  bool _vadInSpeechState = false; // whether we currently consider user speaking

  @override
  void initState() {
    super.initState();
    _deepgram = Deepgram(widget.deepgramApiKey);
    // _initRecorder();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _startSTT();
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialAIGreeting();
    });
  }

  @override
  void dispose() {
    _activeTTS?.stopPlayer();
    _silenceTimer?.cancel();
    _sttSubscription?.cancel();
    _audioController?.close();
    _forwardingController?.close();
    _recorder?.closeRecorder();
    _recorderProgressSub?.cancel();
    // _recorderProgressSub = null;
    super.dispose();
  }

  Future<void> _initRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();

    try {
      final session = await AudioSession.instance;

      await session.configure(AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.defaultToSpeaker |
                AVAudioSessionCategoryOptions.allowBluetooth |
                AVAudioSessionCategoryOptions.mixWithOthers,
        avAudioSessionMode: AVAudioSessionMode.voiceChat, // BEST for STT/VAD
        androidAudioAttributes: const AndroidAudioAttributes(
          usage: AndroidAudioUsage.voiceCommunication,
          contentType: AndroidAudioContentType.speech,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: false,
      ));

      await session.setActive(true);
    } catch (e) {
      debugPrint("⚠️ AudioSession init failed (continuing): $e");
    }

    _recorder!.setSubscriptionDuration(const Duration(milliseconds: 200));
  }

  Future<void> _handleInitialAIGreeting() async {
    if (!_isFirstTurn) return;

    setState(() {
      _statusText = "Thinking of a question";
      _isTTSPlaying = true;
    });

    try {
      // You said this is already handled on your backend
      await widget.chatCompletion("Ask me a question");

      final reply = FFAppState().agentResponse;

      if (reply is String && reply.trim().isNotEmpty) {
        // 🔊 NOW the AI is actually about to speak
        setState(() {
          _statusText = "Speaking";
        });
        await streamTTS(reply, widget.apiKey);
      }
    } catch (e) {
      debugPrint("Initial AI greeting failed: $e");
    } finally {
      setState(() {
        _isTTSPlaying = false;
        _isFirstTurn = false; // 🔑 important
      });

      // 🔑 ONLY NOW do we touch the recorder
      await _initRecorder();
      await _startSTT();
    }
  }

  Future<void> _startSTT() async {
    if (_isRecording) return;

    setState(() {
      _transcript = "";
      _isRecording = true;
      _isStreaming = true;
      _statusText = "Loading";
      _recordStartTime = DateTime.now();
      _gotFirstTranscript = false;
      _lastVoiceActivity = null;
    });

    // create controllers
    _audioController = StreamController<Uint8List>();
    _forwardingController = StreamController<Uint8List>();

    // forwarding listener: decides whether to forward mic buffers to Deepgram
    _forwardingController!.stream.listen((buffer) {
      if (_statusText == 'Loading') {
        setState(() => _statusText = 'Listening');
      }
      if (_isStreaming && !_isTTSPlaying) {
        try {
          _audioController?.add(buffer);

          // VOICE ACTIVITY DETECTION - This is the ONLY silence detection now
          // _processVoiceActivity(buffer);
        } catch (e) {
          debugPrint("❌ forward add error: $e");
        }
      }
    }, onError: (e) {
      debugPrint("❌ forwarding stream error: $e");
    });

    // connect Deepgram to the audio controller stream
    final sttStream = _deepgram.listen.live(
      _audioController!.stream,
      queryParams: {
        'encoding': 'linear16',
        'sample_rate': 24000,
        'language': 'en',
        'punctuation': true,
      },
    );

    // listen to Deepgram events
    _sttSubscription = sttStream.listen((res) {
      // mark listening once first event arrives
      if (_statusText == "Loading") setState(() => _statusText = "Listening");

      debugPrint(
          "Deepgram event: ${res.runtimeType}, transcript: ${res.transcript}");

      // append transcript text (NO SILENCE TIMING HERE - only content)
      try {
        final transcriptMaybe = res.transcript;
        if (transcriptMaybe != null &&
            (transcriptMaybe as String).trim().isNotEmpty &&
            !_isTTSPlaying) {
          final transcriptStr = (transcriptMaybe as String).trim();

          if (transcriptStr.length >= 2) {
            setState(() {
              _transcript += transcriptStr + " ";
            });

            // Mark that we got meaningful content (but don't use for silence detection)
            if (!_gotFirstTranscript) {
              _gotFirstTranscript = true;
            }

            debugPrint(
                "✅ Transcript updated: '${transcriptStr}' (total length: ${_transcript.length})");
          }
        }
      } catch (e) {
        debugPrint("Error handling Deepgram res: $e");
      }
    }, onError: (err) {
      debugPrint("STT stream error: $err");
    });

    // finally start recorder and feed its stream into forwardingController
    try {
      await _recorder!.startRecorder(
        codec: Codec.pcm16,
        sampleRate: 24000,
        numChannels: 1,
        toStream: _forwardingController!.sink,
      );

      // _recorder!.setSubscriptionDuration(const Duration(milliseconds: 200));

      // 🕰️🕰️
      // subscribe to recorder progress (decibels)
      _recorderProgressSub =
          _recorder!.onProgress!.listen((RecordingDisposition disp) {
        print(disp.decibels);

        if (disp.decibels == null) return;
        final double db =
            disp.decibels!; // recorder-provided dB value (already calibrated)
        // EMA smoothing (in the dB domain)
        _emaDb = _emaAlpha * db + (1 - _emaAlpha) * _emaDb;

        // Hysteresis-based speech detection
        if (!_vadInSpeechState && _emaDb >= _speechOnDb) {
          // Enter speech state
          _vadInSpeechState = true;
          _quietStartTime = null;
          _lastVoiceActivity =
              DateTime.now(); // existing field you use elsewhere
          // optional debug
          debugPrint(
              "🔊 VAD: speech START (emaDb=${_emaDb.toStringAsFixed(1)} dB)");
          // If a silence timer was running, cancel it — we heard voice
          _silenceTimer?.cancel();
          _silenceTimer = null;
        } else if (_vadInSpeechState && _emaDb < _speechOffDb) {
          // Start (or continue) quiet detection
          _quietStartTime ??= DateTime.now();
          final quietMs =
              DateTime.now().difference(_quietStartTime!).inMilliseconds;

          // optional debug
          // debugPrint("🔇 VAD: quiet (emaDb=${_emaDb.toStringAsFixed(1)} dB) quietMs=$quietMs");

          // Only after hangoverMs of continuous quiet do we call the same on-silence handler
          if (quietMs >= _hangoverMs) {
            // mark we've left speech state
            _vadInSpeechState = false;
            // update last voice time (we just observed quiet)
            _lastVoiceActivity =
                DateTime.now().subtract(Duration(milliseconds: quietMs));
            debugPrint(
                "🤫 VAD: sustained quiet ($quietMs ms) → scheduling end-of-turn check");
            // call your existing silence check directly (it will re-check minRecordingMs etc.)
            _onSilenceTimeout();
          }
        } else {
          // we're either not in speech and below ON threshold (still quiet) OR in speech and above OFF threshold (still talking)
          // update lastVoiceActivity while we're above a lower "active" threshold to help robust checks
          if (_emaDb >= _speechOffDb) {
            _lastVoiceActivity = DateTime.now();
          }
          // reset quietStartTime if we get activity again
          if (_emaDb >= _speechOffDb) _quietStartTime = null;
        }
      }, onError: (e) {
        debugPrint('❌ onProgress error: $e');
      });

      debugPrint("✅ Recorder started successfully");
    } catch (e) {
      debugPrint("❌ Failed to start recorder: $e");
      setState(() {
        _statusText = "error - recorder failed";
        _isRecording = false;
        _isStreaming = false;
      });
      rethrow;
    }
  }

  /// Simple streamTTS using openai_tts (keeps behavior you provided)
  Future<void> streamTTS(String aiResponse, String? apiKey) async {
    try {
      final session = await AudioSession.instance;
      await session.configure(AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.defaultToSpeaker |
                AVAudioSessionCategoryOptions.allowBluetooth,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      ));
      await session.setActive(true);
    } catch (e) {
      debugPrint('AudioSession config failed (continuing): $e');
    }

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('[TTS] API key is required.');
    }

    final tts = OpenaiTTS(apiKey: apiKey);
    _activeTTS = tts;

    // Create a completer to track when TTS is actually finished
    final Completer<void> ttsCompleter = Completer<void>();

    tts.ttsStatusStream.listen((status) {
      switch (status) {
        case OpenaiTTSStatus.fetching:
          print('🏃‍♂️ AI Agent fetching audio from OpenAI.');
          break;
        case OpenaiTTSStatus.playing:
          print('✅ AI Agent is playing.');
          break;
        case OpenaiTTSStatus.stopped:
          print('❌ AI Agent stopped speaking.');
          if (!ttsCompleter.isCompleted) {
            ttsCompleter.complete();
          }
          break;
        case OpenaiTTSStatus.completed:
          print('🔥 AI Agent completed speaking.');
          if (!ttsCompleter.isCompleted) {
            ttsCompleter.complete();
          }
          break;
      }
    });

    try {
      await tts.streamSpeak(
        aiResponse,
        model: OpenaiTTSModel.tts1,
        voice: OpenaiTTSVoice.ash,
        onData: (Uint8List chunk) {
          // optional: debug chunks
        },
      );

      // Wait for TTS to actually complete
      await ttsCompleter.future;
    } catch (e) {
      print('🤮 TTS ERROR: $e');
      rethrow;
    } finally {
      // ensure player fully stopped before returning
      await tts.stopPlayer();
      // Add a small delay to ensure audio resources are fully released
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

// PURE Voice Activity Detection - the ONLY silence detection method
  void _processVoiceActivity(Uint8List buffer) {
    if (buffer.length < 2) return;

    final ints = buffer.buffer.asInt16List();
    if (ints.isEmpty) return;

    // compute RMS and normalized energy
    double rms = sqrt(ints.fold<double>(0, (s, x) => s + x * x) / ints.length);
    double normalized = rms / 32768.0;

    // Debug every so often (remove later)
    // debugPrint('RMS normalized: ${normalized.toStringAsFixed(3)}');

    final bool voiceDetected = normalized > _voiceRmsThreshold;

    if (voiceDetected) {
      // reset silent frame counter and mark last voice
      _silentFrameCount = 0;
      _lastVoiceActivity = DateTime.now();
      // if there's a silence timer running, cancel it (we heard voice)
      if (_silenceTimer != null) {
        _silenceTimer?.cancel();
        _silenceTimer = null;
        debugPrint('🔊 Voice resumed — canceled silence timer');
      }
      // optional debug
      debugPrint('🎤 Voice detected (RMS=${normalized.toStringAsFixed(3)})');
    } else {
      // increment silent frame counter
      _silentFrameCount++;
      // optional debug
      // debugPrint('🔇 Silent frame #$_silentFrameCount (RMS=${normalized.toStringAsFixed(3)})');

      // if we observed enough consecutive silent frames, consider starting a silence timer
      if (_gotFirstTranscript &&
          _silenceTimer == null &&
          _silentFrameCount >= _silentFrameThreshold) {
        final recordDuration = DateTime.now()
            .difference(_recordStartTime ?? DateTime.now())
            .inMilliseconds;
        if (recordDuration >= _minRecordingMs) {
          // start a defensive silence timer (final guard)
          debugPrint(
              '🤫 Sustained silence frames detected ($_silentFrameCount). Starting silence timer.');
          _silenceTimer = Timer(Duration(milliseconds: _silenceThreshold), () {
            debugPrint(
                '🔇 VOICE SILENCE timeout fired after $_silenceThreshold ms');
            _onSilenceTimeout();
          });
        } else {
          // too short -> wait a bit longer
          debugPrint('⏳ Silence frames but recordDuration < min; waiting');
        }
      }
    }
  }

  // Called when VOICE inactivity indicatess user finished speaking
  Future<void> _onSilenceTimeout() async {
    _silenceTimer?.cancel();
    _silenceTimer = null;

    if (!_isStreaming || _isTTSPlaying) return;

    // Check end conditions using ONLY voice activity (no transcript timing)
    final now = DateTime.now();
    final recordDuration =
        now.difference(_recordStartTime ?? now).inMilliseconds;
    final transcriptLength = _transcript.trim().length;
    final timeSinceLastVoice = _lastVoiceActivity != null
        ? now.difference(_lastVoiceActivity!).inMilliseconds
        : recordDuration;

    debugPrint("🔍 VOICE-ONLY SILENCE DETECTION:");
    debugPrint("   recordDuration: ${recordDuration}ms");
    debugPrint("   transcriptLength: $transcriptLength");
    debugPrint("   timeSinceLastVoice: ${timeSinceLastVoice}ms");
    debugPrint("   lastVoiceActivity: $_lastVoiceActivity");

    // Require: minimum time + meaningful content + actual voice silence
    if (recordDuration < _minRecordingMs ||
        transcriptLength < 5 ||
        timeSinceLastVoice < _silenceThreshold) {
      debugPrint("⏳ Not ready to end turn yet - extending...");
      debugPrint(
          "   Fails: minTime=${recordDuration < _minRecordingMs}, content=${transcriptLength < 5}, voiceSilence=${timeSinceLastVoice < _silenceThreshold}");

      // Extend the silence timer
      _silenceTimer = Timer(
        Duration(milliseconds: _silenceThreshold),
        () => _onSilenceTimeout(),
      );
      return;
    }

    debugPrint(
        "✅ Voice silence confirmed - processing turn: '${_transcript.trim()}'");

    // Pause recording completely during AI response
    await _pauseRecording();

    final userText = _transcript.trim();
    if (userText.isNotEmpty) {
      try {
        // call chatCompletion - user provides this function
        await widget.chatCompletion(userText);
        dynamic reply = FFAppState().agentResponse;

        // If chatCompletion returned a String reply, stream TTS for it
        if (reply is String && reply.trim().isNotEmpty) {
          setState(() {
            _isTTSPlaying = true;
            _statusText = "Speaking";
          });

          try {
            // Wait for TTS to completely finish before resuming recording
            await streamTTS(reply, widget.apiKey);
          } catch (ttsErr) {
            debugPrint("TTS playback error: $ttsErr");
          } finally {
            setState(() {
              _isTTSPlaying = false;
            });
          }
        } else {
          debugPrint(
              "chatCompletion returned non-string or null; skipping streamTTS");
        }
      } catch (e) {
        debugPrint("chatCompletion failed: $e");
        setState(() {
          _isTTSPlaying = false;
        });
      }
    } else {
      debugPrint("No transcript captured.");
    }

    // Resume recording after TTS is completely finished
    await _resumeRecording();
  }

  // Properly pause the recorder
  Future<void> _pauseRecording() async {
    if (!_isRecording) return;

    debugPrint("🛑 Pausing recording...");

    setState(() {
      _isStreaming = false;
      _statusText = "Thinking";
    });

    try {
      // Stop the recorder completely to free audio resources
      if (_recorder?.isRecording == true) {
        await _recorder?.stopRecorder();
        debugPrint("✅ Recorder stopped");
      }

      // Close current streams
      await _audioController?.close();
      await _forwardingController?.close();
      _recorderProgressSub?.cancel();
      // _recorderProgressSub = null;
      _sttSubscription?.cancel();

      setState(() {
        _isRecording = false;
      });

      debugPrint("✅ Recording paused successfully");
    } catch (e) {
      debugPrint("❌ Error pausing recording: $e");
    }
  }

  // Properly resume recording
  Future<void> _resumeRecording() async {
    try {
      // Clear transcript and reset state
      setState(() {
        _transcript = "";
        _isStreaming = true;
        _isTTSPlaying = false;
        _lastVoiceActivity = null;
      });

      // Add delay to ensure audio resources are completely free
      await Future.delayed(const Duration(milliseconds: 500));

      // Restart STT
      await _startSTT();
    } catch (e) {
      debugPrint("Error resuming recording: $e");
      // If restart fails, try again after a longer delay
      await Future.delayed(const Duration(milliseconds: 1000));
      try {
        await _startSTT();
      } catch (retryError) {
        debugPrint("Retry restart failed: $retryError");
        setState(() {
          _statusText = "error - please restart";
          _isRecording = false;
          _isStreaming = false;
        });
      }
    }
  }

  // Public helpers
  Future<void> pauseStreaming() async {
    if (!_isStreaming) return;
    _silenceTimer?.cancel();
    _silenceTimer = null;
    await _pauseRecording();
  }

  Future<void> resumeStreaming() async {
    if (_isStreaming || _isTTSPlaying) return;
    await _resumeRecording();
  }

  @override
  Widget build(BuildContext context) {
    final bool isThinking = _statusText == "Thinking";
    final bool isLoading = _statusText == "Loading";
    final bool isSpeaking = _statusText == "Speaking";

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 300,
      color: Colors.transparent,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "$_statusText",
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w500,
              color: widget.fontColor,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
