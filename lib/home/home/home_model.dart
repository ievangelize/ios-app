import '/backend/supabase/supabase.dart';
import '/components/appbar_home/appbar_home_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  bool quoteExpanded = false;

  double? quoteHeight;

  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? homeSupabaseStream;
  // Model for appbarHome component.
  late AppbarHomeModel appbarHomeModel;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<UserLessonProgressRow>? ulps;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<CourseLessonsRow>? lessons;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    appbarHomeModel = createModel(context, () => AppbarHomeModel());
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    appbarHomeModel.dispose();
    navBarModel.dispose();
  }
}
