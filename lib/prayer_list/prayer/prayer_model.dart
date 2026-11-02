import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'prayer_widget.dart' show PrayerWidget;
import 'package:flutter/material.dart';

class PrayerModel extends FlutterFlowModel<PrayerWidget> {
  ///  Local state fields for this page.

  int? queuePositiion;

  ///  State fields for stateful widgets in this page.

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Backend Call - Update Row(s)] action in largeBtn widget.
  List<PrayerTargetsRow>? target;
  // Stores action output result for [Backend Call - API (Send Push Notification)] action in largeBtn widget.
  ApiCallResponse? apiResultewm;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel.dispose();
  }
}
