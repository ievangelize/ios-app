// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart';
import 'package:scroll_to/scroll_to.dart';
import '/custom_code/scrollable.dart';

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
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    // ✅ Register this widget's GlobalKey by ID
    GlobalScrollService.registerKey(widget.id, _key);
    print("✅ Registered ID: ${widget.id}");
  }

  @override
  void dispose() {
    GlobalScrollService.unregisterKey(widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key, // ✅ This is what we'll measure
      child: widget.child(),
    );
  }
}
