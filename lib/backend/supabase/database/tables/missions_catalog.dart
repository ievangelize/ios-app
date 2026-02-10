import '../database.dart';

class MissionsCatalogTable extends SupabaseTable<MissionsCatalogRow> {
  @override
  String get tableName => 'missionsCatalog';

  @override
  MissionsCatalogRow createRow(Map<String, dynamic> data) =>
      MissionsCatalogRow(data);
}

class MissionsCatalogRow extends SupabaseDataRow {
  MissionsCatalogRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MissionsCatalogTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get xpReward => getField<int>('xp_reward');
  set xpReward(int? value) => setField<int>('xp_reward', value);

  String? get lessonId => getField<String>('lesson_id');
  set lessonId(String? value) => setField<String>('lesson_id', value);

  int? get peopleComplete => getField<int>('people_complete');
  set peopleComplete(int? value) => setField<int>('people_complete', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
