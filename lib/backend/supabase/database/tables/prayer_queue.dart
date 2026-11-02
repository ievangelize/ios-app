import '../database.dart';

class PrayerQueueTable extends SupabaseTable<PrayerQueueRow> {
  @override
  String get tableName => 'prayerQueue';

  @override
  PrayerQueueRow createRow(Map<String, dynamic> data) => PrayerQueueRow(data);
}

class PrayerQueueRow extends SupabaseDataRow {
  PrayerQueueRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PrayerQueueTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get prayerTargetId => getField<String>('prayer_target_id');
  set prayerTargetId(String? value) =>
      setField<String>('prayer_target_id', value);

  int? get position => getField<int>('position');
  set position(int? value) => setField<int>('position', value);

  DateTime? get lastPrayedAt => getField<DateTime>('last_prayed_at');
  set lastPrayedAt(DateTime? value) =>
      setField<DateTime>('last_prayed_at', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
