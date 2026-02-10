import '/components/app_bar_image/app_bar_image_widget.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'enter_email_widget.dart' show EnterEmailWidget;
import 'package:flutter/material.dart';

class EnterEmailModel extends FlutterFlowModel<EnterEmailWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Model for appBarImage component.
  late AppBarImageModel appBarImageModel;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
    appBarImageModel = createModel(context, () => AppBarImageModel());
  }

  @override
  void dispose() {
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    largeBtnModel.dispose();
    appBarImageModel.dispose();
  }
}
