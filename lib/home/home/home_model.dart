import '/components/mission/mission_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - getFCMToken] action in TextField widget.
  String? response;
  // Models for mission dynamic component.
  late FlutterFlowDynamicModels<MissionModel> missionModels;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    missionModels = FlutterFlowDynamicModels(() => MissionModel());
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    missionModels.dispose();
    navBarModel.dispose();
  }
}
