import '../database.dart';

class ImpactTable extends SupabaseTable<ImpactRow> {
  @override
  String get tableName => 'impact';

  @override
  ImpactRow createRow(Map<String, dynamic> data) => ImpactRow(data);
}

class ImpactRow extends SupabaseDataRow {
  ImpactRow(super.data);

  @override
  SupabaseTable get table => ImpactTable();

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get missionId => getField<String>('mission_id');
  set missionId(String? value) => setField<String>('mission_id', value);
}
