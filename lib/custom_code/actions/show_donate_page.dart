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

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> showDonatePage() async {
  try {
    final prefs = await SharedPreferences.getInstance();

    // Get current launch count
    int launches = prefs.getInt('launch_count') ?? 0;

    // Increment
    launches++;
    await prefs.setInt('launch_count', launches);

    // Return true on every third launch
    return launches % 6 == 0;
  } catch (e) {
    return false;
  }
}
