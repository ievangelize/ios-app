import '/components/app_bar_image/app_bar_image_widget.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'confirm_o_t_p_widget.dart' show ConfirmOTPWidget;
import 'package:flutter/material.dart';

class ConfirmOTPModel extends FlutterFlowModel<ConfirmOTPWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for OTP widget.
  FocusNode? otpFocusNode;
  TextEditingController? otpTextController;
  String? Function(BuildContext, String?)? otpTextControllerValidator;
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
    otpFocusNode?.dispose();
    otpTextController?.dispose();

    largeBtnModel.dispose();
    appBarImageModel.dispose();
  }
}
