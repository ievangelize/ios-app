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

Future<int> fetchSpeechAndPlay(
  String promptText,
  String? apiKey,
) async {
  // Ensure the API key is provided
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('API key is required.');
  }

  // ---------- 1. Call OpenAI TTS ----------
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

  // Handle the response
  if (response.statusCode == 200) {
    Uint8List audioBytes = response.bodyBytes;

    // ---------- 2. Play the bytes ----------
    final player = AudioPlayer();
    await player.setAudioSource(MyByteSource(audioBytes));

    // Capture duration after it loads
    Duration? dur = await player.durationStream.firstWhere((d) => d != null);

    await player.play();

    // Optional: wait for playback to finish
    // await player.playerStateStream
    //     .firstWhere((s) => s.processingState == ProcessingState.completed);

    return dur?.inMilliseconds ?? 0;
  } else {
    // If the server did not return a "200 OK response",
    // throw an exception
    throw Exception(
        'Failed to generate speech. Status code: ${response.statusCode}');
  }
}
