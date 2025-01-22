import '../database.dart';

class ReachedTable extends SupabaseTable<ReachedRow> {
  @override
  String get tableName => 'reached';

  @override
  ReachedRow createRow(Map<String, dynamic> data) => ReachedRow(data);
}

class ReachedRow extends SupabaseDataRow {
  ReachedRow(super.data);

  @override
  SupabaseTable get table => ReachedTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get name => getField<String>('Name');
  set name(String? value) => setField<String>('Name', value);

  String? get email => getField<String>('Email');
  set email(String? value) => setField<String>('Email', value);

  String? get phone => getField<String>('Phone');
  set phone(String? value) => setField<String>('Phone', value);

  String? get address => getField<String>('Address');
  set address(String? value) => setField<String>('Address', value);

  String? get note => getField<String>('Note');
  set note(String? value) => setField<String>('Note', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get createdBy => getField<String>('created_by');
  set createdBy(String? value) => setField<String>('created_by', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  bool? get active => getField<bool>('active');
  set active(bool? value) => setField<bool>('active', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  String? get churchId => getField<String>('church_id');
  set churchId(String? value) => setField<String>('church_id', value);

  bool? get pluggedIn => getField<bool>('plugged_in');
  set pluggedIn(bool? value) => setField<bool>('plugged_in', value);
}
