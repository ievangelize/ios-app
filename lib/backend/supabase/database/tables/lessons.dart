import '../database.dart';

class LessonsTable extends SupabaseTable<LessonsRow> {
  @override
  String get tableName => 'lessons';

  @override
  LessonsRow createRow(Map<String, dynamic> data) => LessonsRow(data);
}

class LessonsRow extends SupabaseDataRow {
  LessonsRow(super.data);

  @override
  SupabaseTable get table => LessonsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get speaker => getField<String>('speaker');
  set speaker(String? value) => setField<String>('speaker', value);

  String? get duration => getField<String>('duration');
  set duration(String? value) => setField<String>('duration', value);

  String? get audioUrl => getField<String>('audio_url');
  set audioUrl(String? value) => setField<String>('audio_url', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get order => getField<int>('order');
  set order(int? value) => setField<int>('order', value);
}
