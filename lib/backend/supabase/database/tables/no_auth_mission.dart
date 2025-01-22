import '../database.dart';

class NoAuthMissionTable extends SupabaseTable<NoAuthMissionRow> {
  @override
  String get tableName => 'noAuthMission';

  @override
  NoAuthMissionRow createRow(Map<String, dynamic> data) =>
      NoAuthMissionRow(data);
}

class NoAuthMissionRow extends SupabaseDataRow {
  NoAuthMissionRow(super.data);

  @override
  SupabaseTable get table => NoAuthMissionTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
