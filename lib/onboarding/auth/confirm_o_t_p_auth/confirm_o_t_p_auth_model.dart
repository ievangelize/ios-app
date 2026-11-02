import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'confirm_o_t_p_auth_widget.dart' show ConfirmOTPAuthWidget;
import 'package:flutter/material.dart';

class ConfirmOTPAuthModel extends FlutterFlowModel<ConfirmOTPAuthWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for OTP widget.
  TextEditingController? otp;
  FocusNode? otpFocusNode;
  String? Function(BuildContext, String?)? otpValidator;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;

  @override
  void initState(BuildContext context) {
    otp = TextEditingController();
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    otpFocusNode?.dispose();
    otp?.dispose();

    largeBtnModel.dispose();
  }
}
