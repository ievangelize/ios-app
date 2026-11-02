import '/backend/supabase/supabase.dart';
import '/components/tap_to_complete_btn/tap_to_complete_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'horizontal_video_player_widget.dart' show HorizontalVideoPlayerWidget;
import 'package:flutter/material.dart';

class HorizontalVideoPlayerModel
    extends FlutterFlowModel<HorizontalVideoPlayerWidget> {
  ///  Local state fields for this page.

  int? currentCompletedLessons;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in horizontalVideoPlayer widget.
  List<UserLessonProgressRow>? ulp;
  // Stores action output result for [Backend Call - Query Rows] action in horizontalVideoPlayer widget.
  List<UserCourseProgressRow>? ucpCopy;
  // Model for tapToCompleteBtn component.
  late TapToCompleteBtnModel tapToCompleteBtnModel;
  // Stores action output result for [Backend Call - Update Row(s)] action in tapToCompleteBtn widget.
  List<UserCourseProgressRow>? ucp;
  // Stores action output result for [Backend Call - Query Rows] action in tapToCompleteBtn widget.
  List<MissionsCatalogRow>? mission1;
  // Stores action output result for [Backend Call - Query Rows] action in tapToCompleteBtn widget.
  List<MissionsCatalogRow>? mission2;

  @override
  void initState(BuildContext context) {
    tapToCompleteBtnModel = createModel(context, () => TapToCompleteBtnModel());
  }

  @override
  void dispose() {
    tapToCompleteBtnModel.dispose();
  }
}
