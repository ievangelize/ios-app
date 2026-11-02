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

Future<dynamic> parseSimulatorFeedback(String argumentsJson) async {
  // Add your function code here!
  try {
    final decoded = jsonDecode(argumentsJson);

    return {
      'feedback_title': decoded['feedback_title'] ?? '',
      'response': decoded['response'] ?? '',
    };
  } catch (e) {
    return {
      'feedback_title': '',
      'response': '',
      'error': 'Failed to parse arguments'
    };
  }
}
