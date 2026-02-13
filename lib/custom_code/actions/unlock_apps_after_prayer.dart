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

Future<bool> unlockAppsAfterPrayer() async {
  const channel = MethodChannel('focus_blocker');

  try {
    // Unlock for 30 minutes (hardcoded for MVP)
    await channel.invokeMethod('unlockTemporarily', 30);
    print('🔓 Apps unlocked for 30 minutes');
    return true;
  } catch (e) {
    print('❌ Error unlocking apps: $e');
    return false;
  }
}
