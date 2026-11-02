import '../database.dart';

class PrayerTargetsTable extends SupabaseTable<PrayerTargetsRow> {
  @override
  String get tableName => 'prayerTargets';

  @override
  PrayerTargetsRow createRow(Map<String, dynamic> data) =>
      PrayerTargetsRow(data);
}

class PrayerTargetsRow extends SupabaseDataRow {
  PrayerTargetsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PrayerTargetsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get worldview => getField<String>('worldview');
  set worldview(String? value) => setField<String>('worldview', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get stage => getField<int>('stage');
  set stage(int? value) => setField<int>('stage', value);

  String? get location => getField<String>('location');
  set location(String? value) => setField<String>('location', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get avatarUrl => getField<String>('avatar_url');
  set avatarUrl(String? value) => setField<String>('avatar_url', value);

  String? get prayer => getField<String>('prayer');
  set prayer(String? value) => setField<String>('prayer', value);

  bool? get prayed => getField<bool>('prayed');
  set prayed(bool? value) => setField<bool>('prayed', value);

  DateTime? get lastPrayedAt => getField<DateTime>('last_prayed_at');
  set lastPrayedAt(DateTime? value) =>
      setField<DateTime>('last_prayed_at', value);
}
