import '../database.dart';

class FollowupUpdatesTable extends SupabaseTable<FollowupUpdatesRow> {
  @override
  String get tableName => 'followupUpdates';

  @override
  FollowupUpdatesRow createRow(Map<String, dynamic> data) =>
      FollowupUpdatesRow(data);
}

class FollowupUpdatesRow extends SupabaseDataRow {
  FollowupUpdatesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FollowupUpdatesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get reachedId => getField<String>('reached_id');
  set reachedId(String? value) => setField<String>('reached_id', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get method => getField<String>('method');
  set method(String? value) => setField<String>('method', value);
}
