// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:scroll_to/scroll_to.dart';
import '/custom_code/codefiles/scrollable.dart';

class ScrollTargetWidget extends StatefulWidget {
  const ScrollTargetWidget({
    super.key,
    this.width,
    this.height,
    required this.child,
    required this.id,
  });

  final double? width;
  final double? height;
  final Widget Function() child;
  final String id;

  @override
  State<ScrollTargetWidget> createState() => _ScrollTargetWidgetState();
}

class _ScrollTargetWidgetState extends State<ScrollTargetWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = GlobalScrollService.controller;

    /// Prevent crash if controller not ready yet
    if (controller == null) {
      return widget.child();
    }

    return ScrollToWidget(
      id: widget.id,
      controller: controller,
      child: widget.child(),
    );
  }
}
