import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'new_mission_widget.dart' show NewMissionWidget;
import 'package:flutter/material.dart';

class NewMissionModel extends FlutterFlowModel<NewMissionWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel1;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel2;

  @override
  void initState(BuildContext context) {
    largeBtnModel1 = createModel(context, () => LargeBtnModel());
    largeBtnModel2 = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel1.dispose();
    largeBtnModel2.dispose();
  }
}
