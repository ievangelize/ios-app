import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'friends_widget.dart' show FriendsWidget;
import 'package:flutter/material.dart';

class FriendsModel extends FlutterFlowModel<FriendsWidget> {
  ///  Local state fields for this page.

  bool recentActivity = true;

  bool friendList = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Container widget.
  bool? response;
  // Stores action output result for [Backend Call - API (Send Push Notification)] action in Button widget.
  ApiCallResponse? apiResultztj;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
