import '../database.dart';

class StoriesTable extends SupabaseTable<StoriesRow> {
  @override
  String get tableName => 'stories';

  @override
  StoriesRow createRow(Map<String, dynamic> data) => StoriesRow(data);
}

class StoriesRow extends SupabaseDataRow {
  StoriesRow(super.data);

  @override
  SupabaseTable get table => StoriesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get images => getField<String>('images');
  set images(String? value) => setField<String>('images', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  bool? get isActive => getField<bool>('is_active');
  set isActive(bool? value) => setField<bool>('is_active', value);

  String? get thumbnailUrl => getField<String>('thumbnail_url');
  set thumbnailUrl(String? value) => setField<String>('thumbnail_url', value);

  String? get sharableImgUrl => getField<String>('sharable_img_url');
  set sharableImgUrl(String? value) =>
      setField<String>('sharable_img_url', value);
}
