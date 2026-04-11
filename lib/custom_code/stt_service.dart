import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:deepgram_speech_to_text/deepgram_speech_to_text.dart';
import 'package:audio_session/audio_session.dart';

/// ===============================================================
/// GLOBAL STATE (shared across all actions)
/// ===============================================================
FlutterSoundRecorder? _recorder;
Deepgram? _deepgram;

StreamController<Uint8List>? _audioController;
StreamController<Uint8List>? _forwardingController;
StreamSubscription? _sttSubscription;

String _transcript = "";

bool _isInitialized = false;
bool _isRecording = false;
bool _isStreaming = false;

/// ===============================================================
/// INIT (call once)
/// ===============================================================
Future<void> initSTT(String deepgramApiKey) async {
  if (_isInitialized) return;

  _deepgram = Deepgram(deepgramApiKey);

  // Init recorder
  _recorder = FlutterSoundRecorder();
  await _recorder!.openRecorder();

  // Setup audio session
  final session = await AudioSession.instance;
  await session.configure(AudioSessionConfiguration(
    avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
    avAudioSessionCategoryOptions:
        AVAudioSessionCategoryOptions.defaultToSpeaker,
    avAudioSessionMode: AVAudioSessionMode.voiceChat,
  ));
  await session.setActive(true);

  _isInitialized = true;
}

/// ===============================================================
/// START RECORDING
/// ===============================================================
Future<void> startRecording() async {
  // 🔒 Safety checks
  if (!_isInitialized) {
    throw Exception("STT not initialized");
  }
  if (_deepgram == null) {
    throw Exception("Deepgram not initialized");
  }
  if (_recorder == null) {
    throw Exception("Recorder not initialized");
  }

  // 🚫 Prevent double start
  if (_isRecording) return;

  // 🧹 Clean previous session safely
  try {
    await _sttSubscription?.cancel();
  } catch (_) {}

  try {
    await _audioController?.close();
  } catch (_) {}

  try {
    await _forwardingController?.close();
  } catch (_) {}

  // 🔁 Recreate controllers
  _audioController = StreamController<Uint8List>();
  _forwardingController = StreamController<Uint8List>();

  // 🎤 Mic → Forward → Deepgram pipeline
  _forwardingController!.stream.listen((buffer) {
    print("📦 Mic chunk: ${buffer.length}");

    if (_isStreaming &&
        _audioController != null &&
        !_audioController!.isClosed) {
      _audioController!.add(buffer);
    }
  }, onError: (e) {
    print("❌ Forwarding error: $e");
  });

  // 🧠 Connect Deepgram
  final sttStream = _deepgram!.listen.live(
    _audioController!.stream,
    queryParams: {
      'encoding': 'linear16',
      'sample_rate': 24000,
      'language': 'en',
      'punctuation': true,
    },
  );

  _sttSubscription = sttStream.listen((res) {
    print("🧠 Deepgram event");

    final t = res.transcript;
    if (t != null && t.trim().isNotEmpty) {
      print("✅ Transcript: $t");
      _transcript += t.trim() + " ";
    }
  }, onError: (e) {
    print("❌ Deepgram error: $e");
  });

  // 🎬 Start fresh session
  _transcript = "";
  _isRecording = true;
  _isStreaming = true;

  await _recorder!.startRecorder(
    codec: Codec.pcm16,
    sampleRate: 24000,
    numChannels: 1,
    toStream: _forwardingController!.sink,
  );

  // ⏳ Allow recorder to stabilize
  await Future.delayed(const Duration(milliseconds: 100));
}

/// ===============================================================
/// STOP RECORDING
/// ===============================================================
Future<String> stopRecording() async {
  if (!_isRecording) return "";

  _isRecording = false;
  _isStreaming = false;

  // 🛑 Stop mic first
  await _recorder?.stopRecorder();

  // ⏳ Allow final audio frames to flush to Deepgram
  await Future.delayed(const Duration(milliseconds: 200));

  // 🔌 Then close Deepgram stream
  try {
    await _sttSubscription?.cancel();
  } catch (_) {}

  return _transcript.trim();
}

/// ===============================================================
/// CLEANUP (call on page dispose)
/// ===============================================================
Future<void> disposeSTT() async {
  try {
    await _sttSubscription?.cancel();
  } catch (_) {}

  try {
    await _audioController?.close();
  } catch (_) {}

  try {
    await _forwardingController?.close();
  } catch (_) {}

  try {
    await _recorder?.closeRecorder();
  } catch (_) {}

  _isInitialized = false;
  _isRecording = false;
  _isStreaming = false;
}
