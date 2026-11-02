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

import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = SupaFlow.client;
Future verifyOTP(
  String email,
  String token,
) async {
  try {
    await supabase.auth.verifyOTP(
      type: OtpType.magiclink,
      token: token,
      email: email,
    );

    return true;
  } catch (error) {
    return false;
  }
}
