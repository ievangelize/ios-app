import '../database.dart';

class TiersTable extends SupabaseTable<TiersRow> {
  @override
  String get tableName => 'tiers';

  @override
  TiersRow createRow(Map<String, dynamic> data) => TiersRow(data);
}

class TiersRow extends SupabaseDataRow {
  TiersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TiersTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  int? get minXp => getField<int>('min_xp');
  set minXp(int? value) => setField<int>('min_xp', value);

  String? get colorCode => getField<String>('color_code');
  set colorCode(String? value) => setField<String>('color_code', value);
}
