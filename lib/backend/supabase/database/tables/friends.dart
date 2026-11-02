import '../database.dart';

class FriendsTable extends SupabaseTable<FriendsRow> {
  @override
  String get tableName => 'friends';

  @override
  FriendsRow createRow(Map<String, dynamic> data) => FriendsRow(data);
}

class FriendsRow extends SupabaseDataRow {
  FriendsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FriendsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get friendId => getField<String>('friend_id');
  set friendId(String? value) => setField<String>('friend_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
