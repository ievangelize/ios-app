import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'mission_complete_widget.dart' show MissionCompleteWidget;
import 'package:flutter/material.dart';

class MissionCompleteModel extends FlutterFlowModel<MissionCompleteWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? missionCompleteSupabaseStream;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel.dispose();
  }
}
