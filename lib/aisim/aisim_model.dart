import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'aisim_widget.dart' show AisimWidget;
import 'package:flutter/material.dart';

class AisimModel extends FlutterFlowModel<AisimWidget> {
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
