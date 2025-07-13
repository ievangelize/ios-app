import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'update_version_widget.dart' show UpdateVersionWidget;
import 'package:flutter/material.dart';

class UpdateVersionModel extends FlutterFlowModel<UpdateVersionWidget> {
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
