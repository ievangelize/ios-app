import '../database.dart';

class FilterTagsTable extends SupabaseTable<FilterTagsRow> {
  @override
  String get tableName => 'filterTags';

  @override
  FilterTagsRow createRow(Map<String, dynamic> data) => FilterTagsRow(data);
}

class FilterTagsRow extends SupabaseDataRow {
  FilterTagsRow(super.data);

  @override
  SupabaseTable get table => FilterTagsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get order => getField<int>('order');
  set order(int? value) => setField<int>('order', value);
}
