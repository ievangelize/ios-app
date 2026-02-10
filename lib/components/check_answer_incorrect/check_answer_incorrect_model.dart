import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'check_answer_incorrect_widget.dart' show CheckAnswerIncorrectWidget;
import 'package:flutter/material.dart';

class CheckAnswerIncorrectModel
    extends FlutterFlowModel<CheckAnswerIncorrectWidget> {
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
