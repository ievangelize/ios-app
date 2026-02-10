import '../database.dart';

class UserCourseProgressTable extends SupabaseTable<UserCourseProgressRow> {
  @override
  String get tableName => 'user_course_progress';

  @override
  UserCourseProgressRow createRow(Map<String, dynamic> data) =>
      UserCourseProgressRow(data);
}

class UserCourseProgressRow extends SupabaseDataRow {
  UserCourseProgressRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserCourseProgressTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get courseId => getField<String>('course_id');
  set courseId(String? value) => setField<String>('course_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  int? get lessonsCompleted => getField<int>('lessons_completed');
  set lessonsCompleted(int? value) => setField<int>('lessons_completed', value);

  int? get totalLessons => getField<int>('total_lessons');
  set totalLessons(int? value) => setField<int>('total_lessons', value);

  DateTime? get startedAt => getField<DateTime>('started_at');
  set startedAt(DateTime? value) => setField<DateTime>('started_at', value);

  DateTime? get completedAt => getField<DateTime>('completed_at');
  set completedAt(DateTime? value) => setField<DateTime>('completed_at', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime? get lastEngagedAt => getField<DateTime>('last_engaged_at');
  set lastEngagedAt(DateTime? value) =>
      setField<DateTime>('last_engaged_at', value);
}
