import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'aisim_copy_widget.dart' show AisimCopyWidget;
import 'package:flutter/material.dart';

class AisimCopyModel extends FlutterFlowModel<AisimCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [AI Agent - Send Message to Convo Simulator] action in largeBtn widget.
  String? agentResponse;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel.dispose();
  }
}
