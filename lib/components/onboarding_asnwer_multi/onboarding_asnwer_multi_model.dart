import '/flutter_flow/flutter_flow_util.dart';
import 'onboarding_asnwer_multi_widget.dart' show OnboardingAsnwerMultiWidget;
import 'package:flutter/material.dart';

class OnboardingAsnwerMultiModel
    extends FlutterFlowModel<OnboardingAsnwerMultiWidget> {
  ///  Local state fields for this component.

  List<dynamic> selectedId = [];
  void addToSelectedId(dynamic item) => selectedId.add(item);
  void removeFromSelectedId(dynamic item) => selectedId.remove(item);
  void removeAtIndexFromSelectedId(int index) => selectedId.removeAt(index);
  void insertAtIndexInSelectedId(int index, dynamic item) =>
      selectedId.insert(index, item);
  void updateSelectedIdAtIndex(int index, Function(dynamic) updateFn) =>
      selectedId[index] = updateFn(selectedId[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
