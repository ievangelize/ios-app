import '../database.dart';

class ChallengeWeeksTable extends SupabaseTable<ChallengeWeeksRow> {
  @override
  String get tableName => 'challengeWeeks';

  @override
  ChallengeWeeksRow createRow(Map<String, dynamic> data) =>
      ChallengeWeeksRow(data);
}

class ChallengeWeeksRow extends SupabaseDataRow {
  ChallengeWeeksRow(super.data);

  @override
  SupabaseTable get table => ChallengeWeeksTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  bool? get inProgress => getField<bool>('in_progress');
  set inProgress(bool? value) => setField<bool>('in_progress', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get churchId => getField<String>('church_id');
  set churchId(String? value) => setField<String>('church_id', value);

  bool? get global => getField<bool>('global');
  set global(bool? value) => setField<bool>('global', value);
}
