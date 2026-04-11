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

import 'package:scroll_to/scroll_to.dart';
import '/custom_code/scrollable.dart';

Future scrollToIndex(String id) async {
  // Add your function code here!
  await Future.delayed(const Duration(milliseconds: 200));
  final controller = GlobalScrollService.controller;

  if (controller == null) return;

  await controller.scrollToKey(
    id,
    config: ScrollToConfig(
      duration: const Duration(milliseconds: 600),
      animationType: ScrollAnimationType.easeInOut,
      alignment: 0.1,
    ),
  );
}
