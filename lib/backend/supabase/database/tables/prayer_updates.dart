import '../database.dart';

class PrayerUpdatesTable extends SupabaseTable<PrayerUpdatesRow> {
  @override
  String get tableName => 'prayerUpdates';

  @override
  PrayerUpdatesRow createRow(Map<String, dynamic> data) =>
      PrayerUpdatesRow(data);
}

class PrayerUpdatesRow extends SupabaseDataRow {
  PrayerUpdatesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PrayerUpdatesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get prayerTargetId => getField<String>('prayer_target_id');
  set prayerTargetId(String? value) =>
      setField<String>('prayer_target_id', value);

  String? get descriptions => getField<String>('descriptions');
  set descriptions(String? value) => setField<String>('descriptions', value);

  int? get stage => getField<int>('stage');
  set stage(int? value) => setField<int>('stage', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
