import '/backend/api_requests/api_calls.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'account_widget.dart' show AccountWidget;
import 'package:flutter/material.dart';

class AccountModel extends FlutterFlowModel<AccountWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Container widget.
  bool? response;
  // Stores action output result for [Backend Call - API (Delete User)] action in Container widget.
  ApiCallResponse? apiResponse2;
  // Stores action output result for [Backend Call - API (Delete User)] action in Container widget.
  ApiCallResponse? apiResponse;
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
