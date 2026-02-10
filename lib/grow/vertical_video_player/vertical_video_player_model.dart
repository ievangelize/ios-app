import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'vertical_video_player_widget.dart' show VerticalVideoPlayerWidget;
import 'package:flutter/material.dart';

class VerticalVideoPlayerModel
    extends FlutterFlowModel<VerticalVideoPlayerWidget> {
  ///  Local state fields for this page.

  int? currentCompletedLessons;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Update Row(s)] action in CustomVidPlayer widget.
  List<UserCourseProgressRow>? ucp;
  // Stores action output result for [Backend Call - Query Rows] action in CustomVidPlayer widget.
  List<XpEventsRow>? xpEvents2;
  // Stores action output result for [Custom Action - calculateStreak] action in CustomVidPlayer widget.
  List<dynamic>? streak2;
  // Stores action output result for [Backend Call - Query Rows] action in CustomVidPlayer widget.
  List<MissionsCatalogRow>? mission1;
  // Stores action output result for [Backend Call - Query Rows] action in CustomVidPlayer widget.
  List<XpEventsRow>? xpEvents1;
  // Stores action output result for [Custom Action - calculateStreak] action in CustomVidPlayer widget.
  List<dynamic>? streak1;
  // Stores action output result for [Backend Call - Query Rows] action in CustomVidPlayer widget.
  List<MissionsCatalogRow>? mission2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
