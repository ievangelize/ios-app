import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'selected_feedback_widget.dart' show SelectedFeedbackWidget;
import 'package:flutter/material.dart';

class SelectedFeedbackModel extends FlutterFlowModel<SelectedFeedbackWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Icon widget.
  bool? response;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel.dispose();
  }
}
