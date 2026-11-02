import '../database.dart';

class QuizOptionsTable extends SupabaseTable<QuizOptionsRow> {
  @override
  String get tableName => 'quizOptions';

  @override
  QuizOptionsRow createRow(Map<String, dynamic> data) => QuizOptionsRow(data);
}

class QuizOptionsRow extends SupabaseDataRow {
  QuizOptionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => QuizOptionsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get quizId => getField<String>('quiz_id');
  set quizId(String? value) => setField<String>('quiz_id', value);

  String? get optionText => getField<String>('option_text');
  set optionText(String? value) => setField<String>('option_text', value);

  bool? get isCorrect => getField<bool>('is_correct');
  set isCorrect(bool? value) => setField<bool>('is_correct', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
