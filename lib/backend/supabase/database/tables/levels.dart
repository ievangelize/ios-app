import '../database.dart';

class LevelsTable extends SupabaseTable<LevelsRow> {
  @override
  String get tableName => 'levels';

  @override
  LevelsRow createRow(Map<String, dynamic> data) => LevelsRow(data);
}

class LevelsRow extends SupabaseDataRow {
  LevelsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => LevelsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);

  int? get minXp => getField<int>('min_xp');
  set minXp(int? value) => setField<int>('min_xp', value);

  int? get maxXp => getField<int>('max_xp');
  set maxXp(int? value) => setField<int>('max_xp', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
