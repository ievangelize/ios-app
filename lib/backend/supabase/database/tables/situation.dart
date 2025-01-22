import '../database.dart';

class SituationTable extends SupabaseTable<SituationRow> {
  @override
  String get tableName => 'situation';

  @override
  SituationRow createRow(Map<String, dynamic> data) => SituationRow(data);
}

class SituationRow extends SupabaseDataRow {
  SituationRow(super.data);

  @override
  SupabaseTable get table => SituationTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get situationInfo => getField<String>('situation_info');
  set situationInfo(String? value) => setField<String>('situation_info', value);

  String? get gptOutput => getField<String>('gpt_output');
  set gptOutput(String? value) => setField<String>('gpt_output', value);

  String? get createdBy => getField<String>('created_by');
  set createdBy(String? value) => setField<String>('created_by', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  bool? get dislike => getField<bool>('dislike');
  set dislike(bool? value) => setField<bool>('dislike', value);

  String? get dislikeReason => getField<String>('dislike_reason');
  set dislikeReason(String? value) => setField<String>('dislike_reason', value);

  bool? get liked => getField<bool>('liked');
  set liked(bool? value) => setField<bool>('liked', value);

  dynamic get gptOutputJson => getField<dynamic>('gpt_output_json');
  set gptOutputJson(dynamic value) =>
      setField<dynamic>('gpt_output_json', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
