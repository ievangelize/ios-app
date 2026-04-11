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
import '/custom_code/scrollable.dart';

class ScrollableWidget extends StatefulWidget {
  const ScrollableWidget({
    super.key,
    this.width,
    this.height,
    required this.children,
  });

  final double? width;
  final double? height;
  final Widget Function() children;

  @override
  State<ScrollableWidget> createState() => _ScrollableWidgetState();
}

class _ScrollableWidgetState extends State<ScrollableWidget> {
  late ScrollToController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollToController();

    /// 🔥 GLOBAL
    GlobalScrollService.controller = _scrollController;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,

      /// 🔥 THIS IS THE FIX
      child: PrimaryScrollController(
        controller: _scrollController.scrollController,
        child: widget.children(),
      ),
    );
  }
}
