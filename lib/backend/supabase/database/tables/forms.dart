import '../database.dart';

class FormsTable extends SupabaseTable<FormsRow> {
  @override
  String get tableName => 'forms';

  @override
  FormsRow createRow(Map<String, dynamic> data) => FormsRow(data);
}

class FormsRow extends SupabaseDataRow {
  FormsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FormsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get campaignId => getField<String>('campaign_id');
  set campaignId(String? value) => setField<String>('campaign_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  bool? get isLocked => getField<bool>('is_locked');
  set isLocked(bool? value) => setField<bool>('is_locked', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
