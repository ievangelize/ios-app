import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'quiz_option_multi_widget.dart' show QuizOptionMultiWidget;
import 'package:flutter/material.dart';

class QuizOptionMultiModel extends FlutterFlowModel<QuizOptionMultiWidget> {
  ///  Local state fields for this component.

  List<String> selectedOptionIds = [];
  void addToSelectedOptionIds(String item) => selectedOptionIds.add(item);
  void removeFromSelectedOptionIds(String item) =>
      selectedOptionIds.remove(item);
  void removeAtIndexFromSelectedOptionIds(int index) =>
      selectedOptionIds.removeAt(index);
  void insertAtIndexInSelectedOptionIds(int index, String item) =>
      selectedOptionIds.insert(index, item);
  void updateSelectedOptionIdsAtIndex(int index, Function(String) updateFn) =>
      selectedOptionIds[index] = updateFn(selectedOptionIds[index]);

  List<String> correctOptionIds = [];
  void addToCorrectOptionIds(String item) => correctOptionIds.add(item);
  void removeFromCorrectOptionIds(String item) => correctOptionIds.remove(item);
  void removeAtIndexFromCorrectOptionIds(int index) =>
      correctOptionIds.removeAt(index);
  void insertAtIndexInCorrectOptionIds(int index, String item) =>
      correctOptionIds.insert(index, item);
  void updateCorrectOptionIdsAtIndex(int index, Function(String) updateFn) =>
      correctOptionIds[index] = updateFn(correctOptionIds[index]);

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
