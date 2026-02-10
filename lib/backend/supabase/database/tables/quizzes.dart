import '../database.dart';

class QuizzesTable extends SupabaseTable<QuizzesRow> {
  @override
  String get tableName => 'quizzes';

  @override
  QuizzesRow createRow(Map<String, dynamic> data) => QuizzesRow(data);
}

class QuizzesRow extends SupabaseDataRow {
  QuizzesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => QuizzesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get pageId => getField<String>('page_id');
  set pageId(String? value) => setField<String>('page_id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get quizType => getField<String>('quiz_type');
  set quizType(String? value) => setField<String>('quiz_type', value);

  String? get questionText => getField<String>('question_text');
  set questionText(String? value) => setField<String>('question_text', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get answerFeedback => getField<String>('answer_feedback');
  set answerFeedback(String? value) =>
      setField<String>('answer_feedback', value);
}
