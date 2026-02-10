import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'quiz_option_single_widget.dart' show QuizOptionSingleWidget;
import 'package:flutter/material.dart';

class QuizOptionSingleModel extends FlutterFlowModel<QuizOptionSingleWidget> {
  ///  Local state fields for this component.

  String? selectedOptionId;

  String? correctOptionId;

  List<int> haptics = [160, 160];
  void addToHaptics(int item) => haptics.add(item);
  void removeFromHaptics(int item) => haptics.remove(item);
  void removeAtIndexFromHaptics(int index) => haptics.removeAt(index);
  void insertAtIndexInHaptics(int index, int item) =>
      haptics.insert(index, item);
  void updateHapticsAtIndex(int index, Function(int) updateFn) =>
      haptics[index] = updateFn(haptics[index]);

  bool checkedAnswer = false;

  ///  State fields for stateful widgets in this component.

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel.dispose();
  }
}
