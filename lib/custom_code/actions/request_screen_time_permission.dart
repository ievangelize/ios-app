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

Future<bool> requestScreenTimePermission() async {
  const channel = MethodChannel('focus_blocker');

  try {
    final bool granted =
        await channel.invokeMethod<bool>('requestPermission') ?? false;

    if (granted) {
      print('✅ Screen Time permission granted');
    } else {
      print('❌ Screen Time permission denied');
    }

    return granted;
  } catch (e) {
    print('❌ Error requesting permission: $e');
    return false;
  }
}
