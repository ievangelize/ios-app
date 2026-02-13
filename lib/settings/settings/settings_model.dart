import '/backend/api_requests/api_calls.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for SwitchPush widget.
  bool? switchPushValue;
  // Stores action output result for [Custom Action - checkPushPermission] action in SwitchPush widget.
  bool? pushAllowed2;
  // Stores action output result for [Custom Action - requestScreenTimePermission] action in Container widget.
  bool? screenTime;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel1;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in largeBtn widget.
  bool? responseAuth;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel2;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in largeBtn widget.
  bool? response;
  // Stores action output result for [Backend Call - API (Delete User)] action in largeBtn widget.
  ApiCallResponse? apiResponse2;
  // Stores action output result for [Backend Call - API (Delete User)] action in largeBtn widget.
  ApiCallResponse? apiResponse;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    largeBtnModel1 = createModel(context, () => LargeBtnModel());
    largeBtnModel2 = createModel(context, () => LargeBtnModel());
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    largeBtnModel1.dispose();
    largeBtnModel2.dispose();
    navBarModel.dispose();
  }
}
