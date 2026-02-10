import '/backend/supabase/supabase.dart';
import '/components/tap_to_complete_btn/tap_to_complete_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'lesson_widget.dart' show LessonWidget;
import 'package:flutter/material.dart';

class LessonModel extends FlutterFlowModel<LessonWidget> {
  ///  Local state fields for this page.

  List<int> noPagesList = [];
  void addToNoPagesList(int item) => noPagesList.add(item);
  void removeFromNoPagesList(int item) => noPagesList.remove(item);
  void removeAtIndexFromNoPagesList(int index) => noPagesList.removeAt(index);
  void insertAtIndexInNoPagesList(int index, int item) =>
      noPagesList.insert(index, item);
  void updateNoPagesListAtIndex(int index, Function(int) updateFn) =>
      noPagesList[index] = updateFn(noPagesList[index]);

  int currentPage = 1;

  int? currentCompletedLessons;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in lesson widget.
  List<UserLessonProgressRow>? ulp;
  // Stores action output result for [Backend Call - Query Rows] action in lesson widget.
  List<UserCourseProgressRow>? ucp;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for tapToCompleteBtn component.
  late TapToCompleteBtnModel tapToCompleteBtnModel;
  // Stores action output result for [Backend Call - Update Row(s)] action in tapToCompleteBtn widget.
  List<UserCourseProgressRow>? ucp2;
  // Stores action output result for [Backend Call - Query Rows] action in tapToCompleteBtn widget.
  List<XpEventsRow>? xpEvents2;
  // Stores action output result for [Custom Action - calculateStreak] action in tapToCompleteBtn widget.
  List<dynamic>? streak2;
  // Stores action output result for [Backend Call - Query Rows] action in tapToCompleteBtn widget.
  List<MissionsCatalogRow>? mission1;
  // Stores action output result for [Backend Call - Query Rows] action in tapToCompleteBtn widget.
  List<XpEventsRow>? xpEvents1;
  // Stores action output result for [Custom Action - calculateStreak] action in tapToCompleteBtn widget.
  List<dynamic>? streak1;
  // Stores action output result for [Backend Call - Query Rows] action in tapToCompleteBtn widget.
  List<MissionsCatalogRow>? mission2;

  /// Query cache managers for this widget.

  final _quizManager = FutureRequestManager<List<QuizzesRow>>();
  Future<List<QuizzesRow>> quiz({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<QuizzesRow>> Function() requestFn,
  }) =>
      _quizManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearQuizCache() => _quizManager.clear();
  void clearQuizCacheKey(String? uniqueKey) =>
      _quizManager.clearRequest(uniqueKey);

  final _quizSingleManager = FutureRequestManager<List<QuizOptionsRow>>();
  Future<List<QuizOptionsRow>> quizSingle({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<QuizOptionsRow>> Function() requestFn,
  }) =>
      _quizSingleManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearQuizSingleCache() => _quizSingleManager.clear();
  void clearQuizSingleCacheKey(String? uniqueKey) =>
      _quizSingleManager.clearRequest(uniqueKey);

  final _quizMultiManager = FutureRequestManager<List<QuizOptionsRow>>();
  Future<List<QuizOptionsRow>> quizMulti({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<QuizOptionsRow>> Function() requestFn,
  }) =>
      _quizMultiManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearQuizMultiCache() => _quizMultiManager.clear();
  void clearQuizMultiCacheKey(String? uniqueKey) =>
      _quizMultiManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    tapToCompleteBtnModel = createModel(context, () => TapToCompleteBtnModel());
  }

  @override
  void dispose() {
    tapToCompleteBtnModel.dispose();

    /// Dispose query cache managers for this widget.

    clearQuizCache();

    clearQuizSingleCache();

    clearQuizMultiCache();
  }

  /// Action blocks.
  Future aswipe(BuildContext context) async {}
}
