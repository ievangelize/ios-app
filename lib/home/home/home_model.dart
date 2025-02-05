import '/components/mission/mission_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for mission dynamic component.
  late FlutterFlowDynamicModels<MissionModel> missionModels1;
  // Models for mission dynamic component.
  late FlutterFlowDynamicModels<MissionModel> missionModels2;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    missionModels1 = FlutterFlowDynamicModels(() => MissionModel());
    missionModels2 = FlutterFlowDynamicModels(() => MissionModel());
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    missionModels1.dispose();
    missionModels2.dispose();
    navBarModel.dispose();
  }
}
