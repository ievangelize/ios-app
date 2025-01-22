import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(super.data);

  @override
  SupabaseTable get table => UsersTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get fullName => getField<String>('full_name');
  set fullName(String? value) => setField<String>('full_name', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get profileUrl => getField<String>('profile_url');
  set profileUrl(String? value) => setField<String>('profile_url', value);

  bool? get profileAdded => getField<bool>('profile_added');
  set profileAdded(bool? value) => setField<bool>('profile_added', value);

  int? get impact => getField<int>('impact');
  set impact(int? value) => setField<int>('impact', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  bool? get joinedChurch => getField<bool>('joined_church');
  set joinedChurch(bool? value) => setField<bool>('joined_church', value);

  String? get churchId => getField<String>('church_id');
  set churchId(String? value) => setField<String>('church_id', value);

  bool? get churchStaff => getField<bool>('church_staff');
  set churchStaff(bool? value) => setField<bool>('church_staff', value);
}
