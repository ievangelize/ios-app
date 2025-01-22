import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'update_email_widget.dart' show UpdateEmailWidget;
import 'package:flutter/material.dart';

class UpdateEmailModel extends FlutterFlowModel<UpdateEmailWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    largeBtnModel.dispose();
  }
}
