import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'celebrate_button_widget.dart' show CelebrateButtonWidget;
import 'package:flutter/material.dart';

class CelebrateButtonModel extends FlutterFlowModel<CelebrateButtonWidget> {
  ///  Local state fields for this component.

  bool hasCelebrated = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Insert Row] action in ContainerCelebrate widget.
  ActivityReactionsRow? newActivity;
  // Stores action output result for [Backend Call - API (Send Push Notification)] action in ContainerCelebrate widget.
  ApiCallResponse? apiResultfsm;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
