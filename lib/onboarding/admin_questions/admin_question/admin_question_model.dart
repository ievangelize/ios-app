import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'admin_question_widget.dart' show AdminQuestionWidget;
import 'package:flutter/material.dart';

class AdminQuestionModel extends FlutterFlowModel<AdminQuestionWidget> {
  ///  Local state fields for this page.

  String? selectedId;

  ///  State fields for stateful widgets in this page.

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
