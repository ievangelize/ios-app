import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/components/tap_to_complete_btn/tap_to_complete_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'first_mission_widget.dart' show FirstMissionWidget;
import 'package:flutter/material.dart';

class FirstMissionModel extends FlutterFlowModel<FirstMissionWidget> {
  ///  Local state fields for this page.

  String shareMessage =
      'Hey, check out this evangelism app, iEvangelize. It makes sharing the gospel very easy & effective. Give it a try and let me know what you think! Use the link. \n\nhttps://link.ievangelize.app/aFij/download';

  ///  State fields for stateful widgets in this page.

  // Model for tapToCompleteBtn component.
  late TapToCompleteBtnModel tapToCompleteBtnModel;
  // Stores action output result for [Backend Call - Insert Row] action in tapToCompleteBtn widget.
  UserAssignedMissionsRow? newMission;
  // Stores action output result for [Backend Call - Insert Row] action in tapToCompleteBtn widget.
  XpEventsRow? xpEvent;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;

  @override
  void initState(BuildContext context) {
    tapToCompleteBtnModel = createModel(context, () => TapToCompleteBtnModel());
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    tapToCompleteBtnModel.dispose();
    largeBtnModel.dispose();
  }
}
