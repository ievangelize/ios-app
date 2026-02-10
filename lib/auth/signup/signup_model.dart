import '/components/app_bar_image/app_bar_image_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'signup_widget.dart' show SignupWidget;
import 'package:flutter/material.dart';

class SignupModel extends FlutterFlowModel<SignupWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appBarImage component.
  late AppBarImageModel appBarImageModel;

  @override
  void initState(BuildContext context) {
    appBarImageModel = createModel(context, () => AppBarImageModel());
  }

  @override
  void dispose() {
    appBarImageModel.dispose();
  }
}
