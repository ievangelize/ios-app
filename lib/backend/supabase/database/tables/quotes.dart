import '../database.dart';

class QuotesTable extends SupabaseTable<QuotesRow> {
  @override
  String get tableName => 'quotes';

  @override
  QuotesRow createRow(Map<String, dynamic> data) => QuotesRow(data);
}

class QuotesRow extends SupabaseDataRow {
  QuotesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => QuotesTable();

  String? get quoteText => getField<String>('quote_text');
  set quoteText(String? value) => setField<String>('quote_text', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  bool? get isActive => getField<bool>('is_active');
  set isActive(bool? value) => setField<bool>('is_active', value);

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get author => getField<String>('author');
  set author(String? value) => setField<String>('author', value);

  bool? get used => getField<bool>('used');
  set used(bool? value) => setField<bool>('used', value);
}
