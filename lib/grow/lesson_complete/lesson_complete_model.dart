import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'lesson_complete_widget.dart' show LessonCompleteWidget;
import 'package:flutter/material.dart';

class LessonCompleteModel extends FlutterFlowModel<LessonCompleteWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? lessonCompleteSupabaseStream;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel1;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel2;

  @override
  void initState(BuildContext context) {
    largeBtnModel1 = createModel(context, () => LargeBtnModel());
    largeBtnModel2 = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel1.dispose();
    largeBtnModel2.dispose();
  }
}
