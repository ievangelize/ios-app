import '../database.dart';

class ResourcesTable extends SupabaseTable<ResourcesRow> {
  @override
  String get tableName => 'resources';

  @override
  ResourcesRow createRow(Map<String, dynamic> data) => ResourcesRow(data);
}

class ResourcesRow extends SupabaseDataRow {
  ResourcesRow(super.data);

  @override
  SupabaseTable get table => ResourcesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get categoryId => getField<int>('category_id');
  set categoryId(int? value) => setField<int>('category_id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  bool? get isVideo => getField<bool>('is_video');
  set isVideo(bool? value) => setField<bool>('is_video', value);

  String? get mediaUrl => getField<String>('media_url');
  set mediaUrl(String? value) => setField<String>('media_url', value);

  String? get thumbnailUrl => getField<String>('thumbnail_url');
  set thumbnailUrl(String? value) => setField<String>('thumbnail_url', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  int? get shares => getField<int>('shares');
  set shares(int? value) => setField<int>('shares', value);

  String? get subTitle => getField<String>('sub_title');
  set subTitle(String? value) => setField<String>('sub_title', value);

  String? get duration => getField<String>('duration');
  set duration(String? value) => setField<String>('duration', value);

  String? get shareUrl => getField<String>('share_url');
  set shareUrl(String? value) => setField<String>('share_url', value);

  int? get provider => getField<int>('provider');
  set provider(int? value) => setField<int>('provider', value);

  String? get searchMetadata => getField<String>('search_metadata');
  set searchMetadata(String? value) =>
      setField<String>('search_metadata', value);

  String? get searchMetadataTsv => getField<String>('search_metadata_tsv');
  set searchMetadataTsv(String? value) =>
      setField<String>('search_metadata_tsv', value);

  String? get searchThumbnailUrl => getField<String>('search_thumbnail_url');
  set searchThumbnailUrl(String? value) =>
      setField<String>('search_thumbnail_url', value);

  bool? get isVertical => getField<bool>('is_vertical');
  set isVertical(bool? value) => setField<bool>('is_vertical', value);

  int? get order => getField<int>('order');
  set order(int? value) => setField<int>('order', value);
}
