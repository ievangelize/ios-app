import '../database.dart';

class SimulatorFeedbackTable extends SupabaseTable<SimulatorFeedbackRow> {
  @override
  String get tableName => 'simulatorFeedback';

  @override
  SimulatorFeedbackRow createRow(Map<String, dynamic> data) =>
      SimulatorFeedbackRow(data);
}

class SimulatorFeedbackRow extends SupabaseDataRow {
  SimulatorFeedbackRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SimulatorFeedbackTable();

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get personaId => getField<String>('persona_id');
  set personaId(String? value) => setField<String>('persona_id', value);

  String? get feedbackText => getField<String>('feedback_text');
  set feedbackText(String? value) => setField<String>('feedback_text', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get duration => getField<String>('duration');
  set duration(String? value) => setField<String>('duration', value);

  String? get feedbackTitle => getField<String>('feedback_title');
  set feedbackTitle(String? value) => setField<String>('feedback_title', value);
}
