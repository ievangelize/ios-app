import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'encounter_info_widget.dart' show EncounterInfoWidget;
import 'package:flutter/material.dart';

class EncounterInfoModel extends FlutterFlowModel<EncounterInfoWidget> {
  ///  Local state fields for this page.

  bool? saved = false;

  bool? unsaved = false;

  bool? all = true;

  String? tags = 'all';

  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? encounterInfoSupabaseStream;
  Stream<List<FollowupUpdatesRow>>? listViewSupabaseStream;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Container widget.
  bool? response;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<CampaignsRow>? campaign;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
