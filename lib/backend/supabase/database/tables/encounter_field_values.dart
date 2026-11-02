import '../database.dart';

class EncounterFieldValuesTable extends SupabaseTable<EncounterFieldValuesRow> {
  @override
  String get tableName => 'encounter_field_values';

  @override
  EncounterFieldValuesRow createRow(Map<String, dynamic> data) =>
      EncounterFieldValuesRow(data);
}

class EncounterFieldValuesRow extends SupabaseDataRow {
  EncounterFieldValuesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EncounterFieldValuesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get encounterId => getField<String>('encounter_id');
  set encounterId(String? value) => setField<String>('encounter_id', value);

  String? get formFieldId => getField<String>('form_field_id');
  set formFieldId(String? value) => setField<String>('form_field_id', value);

  String? get valueText => getField<String>('value_text');
  set valueText(String? value) => setField<String>('value_text', value);

  bool? get valueBoolean => getField<bool>('value_boolean');
  set valueBoolean(bool? value) => setField<bool>('value_boolean', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
