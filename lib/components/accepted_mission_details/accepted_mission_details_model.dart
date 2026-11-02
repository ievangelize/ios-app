import '/components/tap_to_complete_btn/tap_to_complete_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'accepted_mission_details_widget.dart' show AcceptedMissionDetailsWidget;
import 'package:flutter/material.dart';

class AcceptedMissionDetailsModel
    extends FlutterFlowModel<AcceptedMissionDetailsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for tapToCompleteBtn component.
  late TapToCompleteBtnModel tapToCompleteBtnModel;

  @override
  void initState(BuildContext context) {
    tapToCompleteBtnModel = createModel(context, () => TapToCompleteBtnModel());
  }

  @override
  void dispose() {
    tapToCompleteBtnModel.dispose();
  }
}
