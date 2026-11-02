// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/stt_service.dart';

Future<String> stopRecordingAction() async {
  // Add your function code here!
  try {
    final transcript = await stopRecording();
    return transcript;
  } catch (e) {
    print("Stop Recording Error: $e");
    return "";
  }
}
