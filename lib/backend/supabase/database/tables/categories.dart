import '../database.dart';

class CategoriesTable extends SupabaseTable<CategoriesRow> {
  @override
  String get tableName => 'categories';

  @override
  CategoriesRow createRow(Map<String, dynamic> data) => CategoriesRow(data);
}

class CategoriesRow extends SupabaseDataRow {
  CategoriesRow(super.data);

  @override
  SupabaseTable get table => CategoriesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get order => getField<int>('order');
  set order(int? value) => setField<int>('order', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  String? get posterUrl => getField<String>('poster_url');
  set posterUrl(String? value) => setField<String>('poster_url', value);

  bool? get homePage => getField<bool>('home_page');
  set homePage(bool? value) => setField<bool>('home_page', value);

  bool? get isVertical => getField<bool>('is_vertical');
  set isVertical(bool? value) => setField<bool>('is_vertical', value);
}
