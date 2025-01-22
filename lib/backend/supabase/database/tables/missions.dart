import '../database.dart';

class MissionsTable extends SupabaseTable<MissionsRow> {
  @override
  String get tableName => 'missions';

  @override
  MissionsRow createRow(Map<String, dynamic> data) => MissionsRow(data);
}

class MissionsRow extends SupabaseDataRow {
  MissionsRow(super.data);

  @override
  SupabaseTable get table => MissionsTable();

  int? get challengeWeekId => getField<int>('challenge_week_id');
  set challengeWeekId(int? value) => setField<int>('challenge_week_id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get peopleCompleted => getField<int>('people_completed');
  set peopleCompleted(int? value) => setField<int>('people_completed', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);
}
