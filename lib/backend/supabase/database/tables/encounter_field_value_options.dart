import '../database.dart';

class EncounterFieldValueOptionsTable
    extends SupabaseTable<EncounterFieldValueOptionsRow> {
  @override
  String get tableName => 'encounter_field_value_options';

  @override
  EncounterFieldValueOptionsRow createRow(Map<String, dynamic> data) =>
      EncounterFieldValueOptionsRow(data);
}

class EncounterFieldValueOptionsRow extends SupabaseDataRow {
  EncounterFieldValueOptionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EncounterFieldValueOptionsTable();

  String get encounterFieldValueId =>
      getField<String>('encounter_field_value_id')!;
  set encounterFieldValueId(String value) =>
      setField<String>('encounter_field_value_id', value);

  String get fieldOptionId => getField<String>('field_option_id')!;
  set fieldOptionId(String value) => setField<String>('field_option_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
