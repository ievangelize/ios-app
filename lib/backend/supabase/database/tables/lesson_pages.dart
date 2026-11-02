import '../database.dart';

class LessonPagesTable extends SupabaseTable<LessonPagesRow> {
  @override
  String get tableName => 'lessonPages';

  @override
  LessonPagesRow createRow(Map<String, dynamic> data) => LessonPagesRow(data);
}

class LessonPagesRow extends SupabaseDataRow {
  LessonPagesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => LessonPagesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get lessonId => getField<String>('lesson_id');
  set lessonId(String? value) => setField<String>('lesson_id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);

  String? get type => getField<String>('type');
  set type(String? value) => setField<String>('type', value);

  String? get bodyMd => getField<String>('body_md');
  set bodyMd(String? value) => setField<String>('body_md', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
