import '../database.dart';

class UserMissionsTable extends SupabaseTable<UserMissionsRow> {
  @override
  String get tableName => 'user_missions';

  @override
  UserMissionsRow createRow(Map<String, dynamic> data) => UserMissionsRow(data);
}

class UserMissionsRow extends SupabaseDataRow {
  UserMissionsRow(super.data);

  @override
  SupabaseTable get table => UserMissionsTable();

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get missionId => getField<String>('mission_id');
  set missionId(String? value) => setField<String>('mission_id', value);
}
