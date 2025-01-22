import '../database.dart';

class ChurchStaffTable extends SupabaseTable<ChurchStaffRow> {
  @override
  String get tableName => 'churchStaff';

  @override
  ChurchStaffRow createRow(Map<String, dynamic> data) => ChurchStaffRow(data);
}

class ChurchStaffRow extends SupabaseDataRow {
  ChurchStaffRow(super.data);

  @override
  SupabaseTable get table => ChurchStaffTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get churchId => getField<String>('church_id');
  set churchId(String? value) => setField<String>('church_id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get position => getField<String>('position');
  set position(String? value) => setField<String>('position', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
