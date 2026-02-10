import '../database.dart';

class UserLessonProgressTable extends SupabaseTable<UserLessonProgressRow> {
  @override
  String get tableName => 'user_lesson_progress';

  @override
  UserLessonProgressRow createRow(Map<String, dynamic> data) =>
      UserLessonProgressRow(data);
}

class UserLessonProgressRow extends SupabaseDataRow {
  UserLessonProgressRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserLessonProgressTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get lessonId => getField<String>('lesson_id');
  set lessonId(String? value) => setField<String>('lesson_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get startedAt => getField<DateTime>('started_at');
  set startedAt(DateTime? value) => setField<DateTime>('started_at', value);

  DateTime? get completedAt => getField<DateTime>('completed_at');
  set completedAt(DateTime? value) => setField<DateTime>('completed_at', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get courseId => getField<String>('course_id');
  set courseId(String? value) => setField<String>('course_id', value);
}
