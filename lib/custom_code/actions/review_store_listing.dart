// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:in_app_review/in_app_review.dart';

Future reviewStoreListing() async {
  // Add your function code here!
  final InAppReview inAppReview = InAppReview.instance;

  inAppReview.openStoreListing(appStoreId: '6503224701');
}
