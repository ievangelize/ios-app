import '../database.dart';

class XpEventsTable extends SupabaseTable<XpEventsRow> {
  @override
  String get tableName => 'xp_events';

  @override
  XpEventsRow createRow(Map<String, dynamic> data) => XpEventsRow(data);
}

class XpEventsRow extends SupabaseDataRow {
  XpEventsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => XpEventsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  int? get delta => getField<int>('delta');
  set delta(int? value) => setField<int>('delta', value);

  String? get reason => getField<String>('reason');
  set reason(String? value) => setField<String>('reason', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get idempotencyKey => getField<String>('idempotency_key');
  set idempotencyKey(String? value) =>
      setField<String>('idempotency_key', value);

  bool? get qualifiedForStreak => getField<bool>('qualified_for_streak');
  set qualifiedForStreak(bool? value) =>
      setField<bool>('qualified_for_streak', value);

  bool? get shareWithFriends => getField<bool>('share_with_friends');
  set shareWithFriends(bool? value) =>
      setField<bool>('share_with_friends', value);

  int? get reactionCount => getField<int>('reaction_count');
  set reactionCount(int? value) => setField<int>('reaction_count', value);
}
