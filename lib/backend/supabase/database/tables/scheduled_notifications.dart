import '../database.dart';

class ScheduledNotificationsTable
    extends SupabaseTable<ScheduledNotificationsRow> {
  @override
  String get tableName => 'scheduledNotifications';

  @override
  ScheduledNotificationsRow createRow(Map<String, dynamic> data) =>
      ScheduledNotificationsRow(data);
}

class ScheduledNotificationsRow extends SupabaseDataRow {
  ScheduledNotificationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ScheduledNotificationsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get body => getField<String>('body');
  set body(String? value) => setField<String>('body', value);

  String? get timezone => getField<String>('timezone');
  set timezone(String? value) => setField<String>('timezone', value);

  DateTime? get scheduledAt => getField<DateTime>('scheduled_at');
  set scheduledAt(DateTime? value) => setField<DateTime>('scheduled_at', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  bool? get monday => getField<bool>('monday');
  set monday(bool? value) => setField<bool>('monday', value);

  bool? get tuesday => getField<bool>('tuesday');
  set tuesday(bool? value) => setField<bool>('tuesday', value);

  bool? get wednesday => getField<bool>('wednesday');
  set wednesday(bool? value) => setField<bool>('wednesday', value);

  bool? get thursday => getField<bool>('thursday');
  set thursday(bool? value) => setField<bool>('thursday', value);

  bool? get friday => getField<bool>('friday');
  set friday(bool? value) => setField<bool>('friday', value);

  bool? get saturday => getField<bool>('saturday');
  set saturday(bool? value) => setField<bool>('saturday', value);

  bool? get sunday => getField<bool>('sunday');
  set sunday(bool? value) => setField<bool>('sunday', value);

  String? get reachedId => getField<String>('reached_id');
  set reachedId(String? value) => setField<String>('reached_id', value);
}
