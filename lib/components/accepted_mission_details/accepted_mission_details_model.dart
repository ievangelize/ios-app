import '/backend/supabase/supabase.dart';
import '/components/tap_to_complete_btn/tap_to_complete_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'accepted_mission_details_widget.dart' show AcceptedMissionDetailsWidget;
import 'package:flutter/material.dart';

class AcceptedMissionDetailsModel
    extends FlutterFlowModel<AcceptedMissionDetailsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for tapToCompleteBtn component.
  late TapToCompleteBtnModel tapToCompleteBtnModel;
  // Stores action output result for [Backend Call - Query Rows] action in tapToCompleteBtn widget.
  List<XpEventsRow>? xpEvent;
  // Stores action output result for [Custom Action - calculateStreak] action in tapToCompleteBtn widget.
  List<dynamic>? streak;

  @override
  void initState(BuildContext context) {
    tapToCompleteBtnModel = createModel(context, () => TapToCompleteBtnModel());
  }

  @override
  void dispose() {
    tapToCompleteBtnModel.dispose();
  }
}
