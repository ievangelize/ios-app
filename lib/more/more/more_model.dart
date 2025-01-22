import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'more_widget.dart' show MoreWidget;
import 'package:flutter/material.dart';

class MoreModel extends FlutterFlowModel<MoreWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - checkPushPermission] action in More widget.
  bool? pushallowed;
  // Stores action output result for [Custom Action - checkPushPermission] action in More widget.
  bool? pushPermission;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Container widget.
  bool? response;
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
