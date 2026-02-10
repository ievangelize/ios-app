import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'mic_permission_widget.dart' show MicPermissionWidget;
import 'package:flutter/material.dart';

class MicPermissionModel extends FlutterFlowModel<MicPermissionWidget> {
  ///  Local state fields for this page.

  String simulationState = 'Listening';

  String? chatID;

  List<int> haptics = [
    640,
    920,
    880,
    1560,
    920,
    880,
    1560,
    920,
    880,
    1560,
    920,
    880,
    1560,
    920,
    880,
    1560,
    920,
    880,
    1560,
    920,
    880
  ];
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
