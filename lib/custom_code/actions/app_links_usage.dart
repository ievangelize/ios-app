// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:app_links/app_links.dart';

Future appLinksUsage() async {
  // Add your function code here!
  final appLinks = AppLinks(); // AppLinks is singleton

// Subscribe to all events (initial link and further)
  final sub = appLinks.uriLinkStream.listen((uri) {
    // Do something (navigation, ...)
  });
}
