import '../database.dart';

class CampaignsTable extends SupabaseTable<CampaignsRow> {
  @override
  String get tableName => 'campaigns';

  @override
  CampaignsRow createRow(Map<String, dynamic> data) => CampaignsRow(data);
}

class CampaignsRow extends SupabaseDataRow {
  CampaignsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CampaignsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get groupId => getField<String>('group_id');
  set groupId(String? value) => setField<String>('group_id', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get code => getField<String>('code');
  set code(String? value) => setField<String>('code', value);

  DateTime? get startDate => getField<DateTime>('start_date');
  set startDate(DateTime? value) => setField<DateTime>('start_date', value);

  DateTime? get endDate => getField<DateTime>('end_date');
  set endDate(DateTime? value) => setField<DateTime>('end_date', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  bool? get isActive => getField<bool>('is_active');
  set isActive(bool? value) => setField<bool>('is_active', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get thumbnailUrl => getField<String>('thumbnail_url');
  set thumbnailUrl(String? value) => setField<String>('thumbnail_url', value);
}
