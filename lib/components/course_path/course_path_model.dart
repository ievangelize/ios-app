import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'course_path_widget.dart' show CoursePathWidget;
import 'package:flutter/material.dart';

class CoursePathModel extends FlutterFlowModel<CoursePathWidget> {
  ///  Local state fields for this component.

  List<String> lockedLessonIds = [];
  void addToLockedLessonIds(String item) => lockedLessonIds.add(item);
  void removeFromLockedLessonIds(String item) => lockedLessonIds.remove(item);
  void removeAtIndexFromLockedLessonIds(int index) =>
      lockedLessonIds.removeAt(index);
  void insertAtIndexInLockedLessonIds(int index, String item) =>
      lockedLessonIds.insert(index, item);
  void updateLockedLessonIdsAtIndex(int index, Function(String) updateFn) =>
      lockedLessonIds[index] = updateFn(lockedLessonIds[index]);

  List<String> lessonIds = [];
  void addToLessonIds(String item) => lessonIds.add(item);
  void removeFromLessonIds(String item) => lessonIds.remove(item);
  void removeAtIndexFromLessonIds(int index) => lessonIds.removeAt(index);
  void insertAtIndexInLessonIds(int index, String item) =>
      lessonIds.insert(index, item);
  void updateLessonIdsAtIndex(int index, Function(String) updateFn) =>
      lessonIds[index] = updateFn(lessonIds[index]);

  List<String> ulpIds = [];
  void addToUlpIds(String item) => ulpIds.add(item);
  void removeFromUlpIds(String item) => ulpIds.remove(item);
  void removeAtIndexFromUlpIds(int index) => ulpIds.removeAt(index);
  void insertAtIndexInUlpIds(int index, String item) =>
      ulpIds.insert(index, item);
  void updateUlpIdsAtIndex(int index, Function(String) updateFn) =>
      ulpIds[index] = updateFn(ulpIds[index]);

  List<String> completedLessonIds = [];
  void addToCompletedLessonIds(String item) => completedLessonIds.add(item);
  void removeFromCompletedLessonIds(String item) =>
      completedLessonIds.remove(item);
  void removeAtIndexFromCompletedLessonIds(int index) =>
      completedLessonIds.removeAt(index);
  void insertAtIndexInCompletedLessonIds(int index, String item) =>
      completedLessonIds.insert(index, item);
  void updateCompletedLessonIdsAtIndex(int index, Function(String) updateFn) =>
      completedLessonIds[index] = updateFn(completedLessonIds[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in Column widget.
  List<ResourcesRow>? horResource;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
