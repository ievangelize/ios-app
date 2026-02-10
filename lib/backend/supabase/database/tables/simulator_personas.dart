import '../database.dart';

class SimulatorPersonasTable extends SupabaseTable<SimulatorPersonasRow> {
  @override
  String get tableName => 'simulatorPersonas';

  @override
  SimulatorPersonasRow createRow(Map<String, dynamic> data) =>
      SimulatorPersonasRow(data);
}

class SimulatorPersonasRow extends SupabaseDataRow {
  SimulatorPersonasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SimulatorPersonasTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get thumbnailUrl => getField<String>('thumbnail_url');
  set thumbnailUrl(String? value) => setField<String>('thumbnail_url', value);

  String? get personaInstructions => getField<String>('persona_instructions');
  set personaInstructions(String? value) =>
      setField<String>('persona_instructions', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);
}
