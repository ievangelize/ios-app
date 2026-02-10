import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'encounter_complete_widget.dart' show EncounterCompleteWidget;
import 'package:flutter/material.dart';

class EncounterCompleteModel extends FlutterFlowModel<EncounterCompleteWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? encounterCompleteSupabaseStream;
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
