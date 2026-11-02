import '../database.dart';

class PrayerAvatarsTable extends SupabaseTable<PrayerAvatarsRow> {
  @override
  String get tableName => 'prayerAvatars';

  @override
  PrayerAvatarsRow createRow(Map<String, dynamic> data) =>
      PrayerAvatarsRow(data);
}

class PrayerAvatarsRow extends SupabaseDataRow {
  PrayerAvatarsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PrayerAvatarsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get avatarUrl => getField<String>('avatar_url');
  set avatarUrl(String? value) => setField<String>('avatar_url', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);
}
