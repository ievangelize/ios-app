import '../database.dart';

class ChurchesTable extends SupabaseTable<ChurchesRow> {
  @override
  String get tableName => 'churches';

  @override
  ChurchesRow createRow(Map<String, dynamic> data) => ChurchesRow(data);
}

class ChurchesRow extends SupabaseDataRow {
  ChurchesRow(super.data);

  @override
  SupabaseTable get table => ChurchesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get code => getField<String>('code');
  set code(String? value) => setField<String>('code', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
