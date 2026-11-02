import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'grow_widget.dart' show GrowWidget;
import 'package:flutter/material.dart';

class GrowModel extends FlutterFlowModel<GrowWidget> {
  ///  Local state fields for this page.

  List<int> haptics = [160, 160];
  void addToHaptics(int item) => haptics.add(item);
  void removeFromHaptics(int item) => haptics.remove(item);
  void removeAtIndexFromHaptics(int index) => haptics.removeAt(index);
  void insertAtIndexInHaptics(int index, int item) =>
      haptics.insert(index, item);
  void updateHapticsAtIndex(int index, Function(int) updateFn) =>
      haptics[index] = updateFn(haptics[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in grow widget.
  List<UserCourseProgressRow>? ucp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
