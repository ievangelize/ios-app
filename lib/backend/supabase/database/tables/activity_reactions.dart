import '../database.dart';

class ActivityReactionsTable extends SupabaseTable<ActivityReactionsRow> {
  @override
  String get tableName => 'activity_reactions';

  @override
  ActivityReactionsRow createRow(Map<String, dynamic> data) =>
      ActivityReactionsRow(data);
}

class ActivityReactionsRow extends SupabaseDataRow {
  ActivityReactionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ActivityReactionsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get xpEventId => getField<String>('xp_event_id');
  set xpEventId(String? value) => setField<String>('xp_event_id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get reactionType => getField<String>('reaction_type');
  set reactionType(String? value) => setField<String>('reaction_type', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
