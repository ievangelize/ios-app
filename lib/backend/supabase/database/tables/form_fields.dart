import '../database.dart';

class FormFieldsTable extends SupabaseTable<FormFieldsRow> {
  @override
  String get tableName => 'form_fields';

  @override
  FormFieldsRow createRow(Map<String, dynamic> data) => FormFieldsRow(data);
}

class FormFieldsRow extends SupabaseDataRow {
  FormFieldsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FormFieldsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get formId => getField<String>('form_id');
  set formId(String? value) => setField<String>('form_id', value);

  String? get label => getField<String>('label');
  set label(String? value) => setField<String>('label', value);

  String? get fieldKey => getField<String>('field_key');
  set fieldKey(String? value) => setField<String>('field_key', value);

  String? get fieldType => getField<String>('field_type');
  set fieldType(String? value) => setField<String>('field_type', value);

  bool? get isRequired => getField<bool>('is_required');
  set isRequired(bool? value) => setField<bool>('is_required', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  bool? get isPrimaryDisplay => getField<bool>('is_primary_display');
  set isPrimaryDisplay(bool? value) =>
      setField<bool>('is_primary_display', value);
}
