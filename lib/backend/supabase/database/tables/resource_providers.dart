import '../database.dart';

class ResourceProvidersTable extends SupabaseTable<ResourceProvidersRow> {
  @override
  String get tableName => 'resourceProviders';

  @override
  ResourceProvidersRow createRow(Map<String, dynamic> data) =>
      ResourceProvidersRow(data);
}

class ResourceProvidersRow extends SupabaseDataRow {
  ResourceProvidersRow(super.data);

  @override
  SupabaseTable get table => ResourceProvidersTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get website => getField<String>('website');
  set website(String? value) => setField<String>('website', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get logoUrl => getField<String>('logo_url');
  set logoUrl(String? value) => setField<String>('logo_url', value);
}
