import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'feedback_widget.dart' show FeedbackWidget;
import 'package:flutter/material.dart';

class FeedbackModel extends FlutterFlowModel<FeedbackWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Backend Call - Query Rows] action in largeBtn widget.
  List<XpEventsRow>? xpEvents;
  // Stores action output result for [Custom Action - calculateStreak] action in largeBtn widget.
  List<dynamic>? streak;
  // Stores action output result for [Backend Call - Query Rows] action in IconButton widget.
  List<XpEventsRow>? xpEvents2;
  // Stores action output result for [Custom Action - calculateStreak] action in IconButton widget.
  List<dynamic>? streak2;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel.dispose();
  }
}
