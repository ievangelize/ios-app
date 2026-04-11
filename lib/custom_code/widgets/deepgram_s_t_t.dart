// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
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
import 'package:flutter_sound/flutter_sound.dart';
import 'package:deepgram_speech_to_text/deepgram_speech_to_text.dart';
import 'package:openai_tts/openai_tts.dart';
import 'package:audio_session/audio_session.dart';

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
    this.buttonWidget, // 👈 Injected button
  });

  final double? width;
  final double? height;
  final String deepgramApiKey;
  final Future<dynamic> Function(String words) chatCompletion;
  final String apiKey;
  final double fontSize;
  final Color fontColor;
  final Widget Function()? buttonWidget;

  @override
  State<DeepgramSTT> createState() => _DeepgramSTTState();
}

class _DeepgramSTTState extends State<DeepgramSTT> {
  FlutterSoundRecorder? _recorder;
  OpenaiTTS? _activeTTS;

  StreamController<Uint8List>? _audioController;
  StreamController<Uint8List>? _forwardingController;
  StreamSubscription? _sttSubscription;

  late Deepgram _deepgram;

  String _transcript = "";
  String _statusText = "Idle";

  bool _isRecording = false;
  bool _isStreaming = false;
  bool _isTTSPlaying = false;
  bool _isFirstTurn = true;

  @override
  void initState() {
    super.initState();
    _deepgram = Deepgram(widget.deepgramApiKey);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialAIGreeting();
    });
  }

  @override
  void dispose() {
    _activeTTS?.stopPlayer();
    _sttSubscription?.cancel();
    _audioController?.close();
    _forwardingController?.close();
    _recorder?.closeRecorder();
    super.dispose();
  }

  Future<void> _initRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.voiceChat,
    ));
    await session.setActive(true);
  }

  Future<void> _handleInitialAIGreeting() async {
    if (!_isFirstTurn) return;

    setState(() {
      _statusText = "Thinking...";
      _isTTSPlaying = true;
    });

    await widget.chatCompletion("Ask me a question");
    final reply = FFAppState().agentResponse;

    if (reply is String && reply.isNotEmpty) {
      setState(() => _statusText = "Speaking");
      await streamTTS(reply, widget.apiKey);
    }

    setState(() {
      _isTTSPlaying = false;
      _isFirstTurn = false;
    });

    await _initRecorder();
    await _setupSTT();
  }

  Future<void> _setupSTT() async {
    _audioController = StreamController<Uint8List>();
    _forwardingController = StreamController<Uint8List>();

    _forwardingController!.stream.listen((buffer) {
      if (_isStreaming && !_isTTSPlaying) {
        _audioController?.add(buffer);
      }
    });

    final sttStream = _deepgram.listen.live(
      _audioController!.stream,
      queryParams: {
        'encoding': 'linear16',
        'sample_rate': 24000,
        'language': 'en',
        'punctuation': true,
      },
    );

    _sttSubscription = sttStream.listen((res) {
      final t = res.transcript;
      if (t != null && t.trim().isNotEmpty && !_isTTSPlaying) {
        setState(() {
          _transcript += t.trim() + " ";
        });
      }
    });
  }

  /// 🎤 START RECORDING (BUTTON DOWN)
  Future<void> _startRecording() async {
    if (_isRecording || _isTTSPlaying) return;

    setState(() {
      _transcript = "";
      _isRecording = true;
      _isStreaming = true;
      _statusText = "Listening...";
    });

    await _recorder!.startRecorder(
      codec: Codec.pcm16,
      sampleRate: 24000,
      numChannels: 1,
      toStream: _forwardingController!.sink,
    );
  }

  /// ✋ STOP + PROCESS (BUTTON UP)
  Future<void> _stopRecordingAndProcess() async {
    if (!_isRecording) return;

    setState(() {
      _isRecording = false;
      _isStreaming = false;
      _statusText = "Thinking...";
    });

    await _recorder!.stopRecorder();

    final userText = _transcript.trim();
    if (userText.isEmpty) return;

    try {
      await widget.chatCompletion(userText);
      final reply = FFAppState().agentResponse;

      if (reply is String && reply.isNotEmpty) {
        setState(() {
          _isTTSPlaying = true;
          _statusText = "Speaking";
        });

        await streamTTS(reply, widget.apiKey);

        setState(() {
          _isTTSPlaying = false;
          _statusText = "Idle";
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => _isTTSPlaying = false);
    }
  }

  Future<void> streamTTS(String text, String apiKey) async {
    final tts = OpenaiTTS(apiKey: apiKey);
    _activeTTS = tts;

    final completer = Completer<void>();

    tts.ttsStatusStream.listen((status) {
      if (status == OpenaiTTSStatus.completed ||
          status == OpenaiTTSStatus.stopped) {
        if (!completer.isCompleted) completer.complete();
      }
    });

    await tts.streamSpeak(
      text,
      model: OpenaiTTSModel.tts1,
      voice: OpenaiTTSVoice.ash,
    );

    await completer.future;
    await tts.stopPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 300,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            _statusText,
            style: TextStyle(
              fontSize: widget.fontSize,
              color: widget.fontColor,
            ),
          ),

          const SizedBox(height: 20),

          /// 🔘 BUTTON WRAPPER (HOLD / RELEASE)
          GestureDetector(
            onTapDown: (_) => _startRecording(),
            onTapUp: (_) => _stopRecordingAndProcess(),
            onTapCancel: () => _stopRecordingAndProcess(),
            child: AbsorbPointer(
              absorbing: _isTTSPlaying,
              child: widget.buttonWidget != null
                  ? widget.buttonWidget!()
                  : Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Hold to Speak",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
