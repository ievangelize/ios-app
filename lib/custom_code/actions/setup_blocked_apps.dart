// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

const _channel = MethodChannel('focus_blocker');

/// === SETUP: Let user pick apps to block (one-time setup) ===
Future<bool> setupBlockedApps() async {
  try {
    // Request Screen Time permission
    final bool granted =
        await _channel.invokeMethod<bool>('requestPermission') ?? false;

    if (!granted) {
      print('❌ Family Controls permission denied');
      return false;
    }

    // Show app picker - user selects apps to block
    await _channel.invokeMethod('showAppPicker');

    print('✅ Apps selected for blocking');
    return true;
  } catch (e) {
    print('❌ Error in setupBlockedApps: $e');
    return false;
  }
}
