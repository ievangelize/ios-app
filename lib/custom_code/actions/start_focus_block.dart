// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

const _channel = MethodChannel('focus_blocker');

Future<bool> startFocusBlock() async {
  // 1. Request Screen Time permission
  final bool granted =
      await _channel.invokeMethod<bool>('requestPermission') ?? false;

  if (!granted) return false;

  // 2. REQUIRED: let user pick apps
  await _channel.invokeMethod('showAppPicker');

  // 3. (Optional delay handled elsewhere)
  // 4. Start blocking (immediate or later)
  await _channel.invokeMethod('startBlocking');

  return true;
}
