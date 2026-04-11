import '../database.dart';

class UserGroupsTable extends SupabaseTable<UserGroupsRow> {
  @override
  String get tableName => 'user_groups';

  @override
  UserGroupsRow createRow(Map<String, dynamic> data) => UserGroupsRow(data);
}

class UserGroupsRow extends SupabaseDataRow {
  UserGroupsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserGroupsTable();

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get groupId => getField<String>('group_id');
  set groupId(String? value) => setField<String>('group_id', value);

  String? get role => getField<String>('role');
  set role(String? value) => setField<String>('role', value);

  DateTime? get joinedAt => getField<DateTime>('joined_at');
  set joinedAt(DateTime? value) => setField<DateTime>('joined_at', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);
}
