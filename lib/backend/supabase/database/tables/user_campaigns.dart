import '../database.dart';

class UserCampaignsTable extends SupabaseTable<UserCampaignsRow> {
  @override
  String get tableName => 'user_campaigns';

  @override
  UserCampaignsRow createRow(Map<String, dynamic> data) =>
      UserCampaignsRow(data);
}

class UserCampaignsRow extends SupabaseDataRow {
  UserCampaignsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserCampaignsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get campaignId => getField<String>('campaign_id');
  set campaignId(String? value) => setField<String>('campaign_id', value);

  String? get role => getField<String>('role');
  set role(String? value) => setField<String>('role', value);

  DateTime? get joinedAt => getField<DateTime>('joined_at');
  set joinedAt(DateTime? value) => setField<DateTime>('joined_at', value);
}
