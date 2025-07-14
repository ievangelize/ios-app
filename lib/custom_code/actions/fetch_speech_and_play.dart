// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

// MyByteSource class (can go here)
class MyByteSource extends StreamAudioSource {
  final Uint8List bytes;
  MyByteSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      offset: start,
      contentLength: end - start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}

Future<int> fetchSpeechAndPlay(String promptText, String? apiKey) async {
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('API key is required.');
  }

  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/audio/speech'),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'model': 'tts-1',
      'input': promptText,
      'voice': 'nova',
      'speed': '1',
    }),
  );

  if (response.statusCode == 200) {
    Uint8List audioBytes = response.bodyBytes;

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());

    final player = AudioPlayer();

    player.playerStateStream.listen((state) {
      print('Player state: $state');
    });

    await player.setAudioSource(MyByteSource(audioBytes));
    await player.load();
    await player.play();

    await Future.delayed(await player.duration ?? Duration(seconds: 2));

    return (await player.duration)?.inMilliseconds ?? 0;
  } else {
    throw Exception(
        'Failed to generate speech. Status code: ${response.statusCode}');
  }
}
