import '../database.dart';

class PendingPrayerNotificationUsersTable
    extends SupabaseTable<PendingPrayerNotificationUsersRow> {
  @override
  String get tableName => 'pendingPrayerNotificationUsers';

  @override
  PendingPrayerNotificationUsersRow createRow(Map<String, dynamic> data) =>
      PendingPrayerNotificationUsersRow(data);
}

class PendingPrayerNotificationUsersRow extends SupabaseDataRow {
  PendingPrayerNotificationUsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PendingPrayerNotificationUsersTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
