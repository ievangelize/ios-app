import '../database.dart';

class ConversationMessagesTable extends SupabaseTable<ConversationMessagesRow> {
  @override
  String get tableName => 'conversationMessages';

  @override
  ConversationMessagesRow createRow(Map<String, dynamic> data) =>
      ConversationMessagesRow(data);
}

class ConversationMessagesRow extends SupabaseDataRow {
  ConversationMessagesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ConversationMessagesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get conversationId => getField<String>('conversation_id');
  set conversationId(String? value) =>
      setField<String>('conversation_id', value);

  String? get content => getField<String>('content');
  set content(String? value) => setField<String>('content', value);

  String? get role => getField<String>('role');
  set role(String? value) => setField<String>('role', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get openaiPreviousResponseId =>
      getField<String>('openai_previous_response_id');
  set openaiPreviousResponseId(String? value) =>
      setField<String>('openai_previous_response_id', value);
}
