import '../database.dart';

class CourseLessonsTable extends SupabaseTable<CourseLessonsRow> {
  @override
  String get tableName => 'courseLessons';

  @override
  CourseLessonsRow createRow(Map<String, dynamic> data) =>
      CourseLessonsRow(data);
}

class CourseLessonsRow extends SupabaseDataRow {
  CourseLessonsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CourseLessonsTable();

  String? get courseId => getField<String>('course_id');
  set courseId(String? value) => setField<String>('course_id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);

  int? get estimatedMinutes => getField<int>('estimated_minutes');
  set estimatedMinutes(int? value) => setField<int>('estimated_minutes', value);

  String? get type => getField<String>('type');
  set type(String? value) => setField<String>('type', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  int? get noOfPages => getField<int>('no_of_pages');
  set noOfPages(int? value) => setField<int>('no_of_pages', value);

  bool? get hasMission => getField<bool>('has_mission');
  set hasMission(bool? value) => setField<bool>('has_mission', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get xpReward => getField<int>('xp_reward');
  set xpReward(int? value) => setField<int>('xp_reward', value);

  int? get mediaResourceId => getField<int>('media_resource_id');
  set mediaResourceId(int? value) => setField<int>('media_resource_id', value);
}
