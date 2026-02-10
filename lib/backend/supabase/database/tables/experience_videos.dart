import '../database.dart';

class ExperienceVideosTable extends SupabaseTable<ExperienceVideosRow> {
  @override
  String get tableName => 'experienceVideos';

  @override
  ExperienceVideosRow createRow(Map<String, dynamic> data) =>
      ExperienceVideosRow(data);
}

class ExperienceVideosRow extends SupabaseDataRow {
  ExperienceVideosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ExperienceVideosTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get subTitle => getField<String>('sub_title');
  set subTitle(String? value) => setField<String>('sub_title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get duration => getField<String>('duration');
  set duration(String? value) => setField<String>('duration', value);

  String? get thumbnailUrl => getField<String>('thumbnail_url');
  set thumbnailUrl(String? value) => setField<String>('thumbnail_url', value);

  String? get mediaUrl => getField<String>('media_url');
  set mediaUrl(String? value) => setField<String>('media_url', value);

  String? get shareUrl => getField<String>('share_url');
  set shareUrl(String? value) => setField<String>('share_url', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  bool? get isNew => getField<bool>('is_new');
  set isNew(bool? value) => setField<bool>('is_new', value);
}
