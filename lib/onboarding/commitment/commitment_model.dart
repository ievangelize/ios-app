import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'commitment_widget.dart' show CommitmentWidget;
import 'package:flutter/material.dart';

class CommitmentModel extends FlutterFlowModel<CommitmentWidget> {
  ///  Local state fields for this page.

  List<int> haptics = [0, 500, 400, 300, 300, 200, 200, 100];
  void addToHaptics(int item) => haptics.add(item);
  void removeFromHaptics(int item) => haptics.remove(item);
  void removeAtIndexFromHaptics(int index) => haptics.removeAt(index);
  void insertAtIndexInHaptics(int index, int item) =>
      haptics.insert(index, item);
  void updateHapticsAtIndex(int index, Function(int) updateFn) =>
      haptics[index] = updateFn(haptics[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
