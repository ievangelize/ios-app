import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'tools_widget.dart' show ToolsWidget;
import 'package:flutter/material.dart';

class ToolsModel extends FlutterFlowModel<ToolsWidget> {
  ///  Local state fields for this page.

  bool btnClicked = false;

  ///  State fields for stateful widgets in this page.

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
