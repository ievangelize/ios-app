import '../database.dart';

class FieldOptionsTable extends SupabaseTable<FieldOptionsRow> {
  @override
  String get tableName => 'field_options';

  @override
  FieldOptionsRow createRow(Map<String, dynamic> data) => FieldOptionsRow(data);
}

class FieldOptionsRow extends SupabaseDataRow {
  FieldOptionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FieldOptionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get formFieldId => getField<String>('form_field_id');
  set formFieldId(String? value) => setField<String>('form_field_id', value);

  String? get label => getField<String>('label');
  set label(String? value) => setField<String>('label', value);

  String? get value => getField<String>('value');
  set value(String? value) => setField<String>('value', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
