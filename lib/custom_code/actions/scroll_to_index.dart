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

import 'package:flutter/rendering.dart';
import '/custom_code/scrollable.dart';

Future scrollToIndex(String id) async {
  await Future.delayed(const Duration(milliseconds: 350));

  final controller = GlobalScrollService.controller?.scrollController;
  if (controller == null) {
    print("❌ Controller is NULL");
    return;
  }

  final key = GlobalScrollService.keyRegistry[id];
  if (key == null) {
    print("❌ No key found for ID: $id");
    return;
  }

  final context = key.currentContext;
  if (context == null) {
    print("❌ No context for ID: $id");
    return;
  }

  // ✅ Measure the widget's actual position in the scroll view
  final box = context.findRenderObject() as RenderBox?;
  if (box == null) {
    print("❌ No RenderBox for ID: $id");
    return;
  }

  final scrollableContext = controller.position.context.storageContext;
  final scrollableBox =
      (scrollableContext as BuildContext).findRenderObject() as RenderBox?;

  if (scrollableBox == null) {
    print("❌ No scrollable RenderBox");
    return;
  }

  // ✅ Get position relative to the scroll view
  final position = box.localToGlobal(Offset.zero, ancestor: scrollableBox);
  final targetOffset = (controller.offset + position.dy).clamp(
    controller.position.minScrollExtent,
    controller.position.maxScrollExtent,
  );

  print("🔥 Scrolling to ID: $id at offset: $targetOffset");

  await controller.animateTo(
    targetOffset,
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeInOut,
  );
}
