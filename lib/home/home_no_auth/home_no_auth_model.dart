import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_no_auth_widget.dart' show HomeNoAuthWidget;
import 'package:flutter/material.dart';

class HomeNoAuthModel extends FlutterFlowModel<HomeNoAuthWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - newVersion] action in homeNoAuth widget.
  String? currentVersion;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    navBarModel.dispose();
  }
}
