import '../database.dart';

class UserAssignedMissionsTable extends SupabaseTable<UserAssignedMissionsRow> {
  @override
  String get tableName => 'userAssignedMissions';

  @override
  UserAssignedMissionsRow createRow(Map<String, dynamic> data) =>
      UserAssignedMissionsRow(data);
}

class UserAssignedMissionsRow extends SupabaseDataRow {
  UserAssignedMissionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserAssignedMissionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get missionCatalogId => getField<String>('mission_catalog_id');
  set missionCatalogId(String? value) =>
      setField<String>('mission_catalog_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  int? get xpReward => getField<int>('xp_reward');
  set xpReward(int? value) => setField<int>('xp_reward', value);

  DateTime? get completeAt => getField<DateTime>('complete_at');
  set completeAt(DateTime? value) => setField<DateTime>('complete_at', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
