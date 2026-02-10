import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsersTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get fullName => getField<String>('full_name');
  set fullName(String? value) => setField<String>('full_name', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get profileUrl => getField<String>('profile_url');
  set profileUrl(String? value) => setField<String>('profile_url', value);

  bool? get profileAdded => getField<bool>('profile_added');
  set profileAdded(bool? value) => setField<bool>('profile_added', value);

  int? get impact => getField<int>('impact');
  set impact(int? value) => setField<int>('impact', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  bool? get joinedChurch => getField<bool>('joined_church');
  set joinedChurch(bool? value) => setField<bool>('joined_church', value);

  String? get churchId => getField<String>('church_id');
  set churchId(String? value) => setField<String>('church_id', value);

  bool? get churchStaff => getField<bool>('church_staff');
  set churchStaff(bool? value) => setField<bool>('church_staff', value);

  String? get fcmToken => getField<String>('fcm_token');
  set fcmToken(String? value) => setField<String>('fcm_token', value);

  dynamic get onboardingSnapshot => getField<dynamic>('onboarding_snapshot');
  set onboardingSnapshot(dynamic value) =>
      setField<dynamic>('onboarding_snapshot', value);

  String? get onboardingLevel => getField<String>('onboarding_level');
  set onboardingLevel(String? value) =>
      setField<String>('onboarding_level', value);

  bool? get onboardingComplete => getField<bool>('onboarding_complete');
  set onboardingComplete(bool? value) =>
      setField<bool>('onboarding_complete', value);

  int? get cumulativeXp => getField<int>('cumulative_xp');
  set cumulativeXp(int? value) => setField<int>('cumulative_xp', value);

  String? get currentLevelId => getField<String>('current_level_id');
  set currentLevelId(String? value) =>
      setField<String>('current_level_id', value);

  int? get streak => getField<int>('streak');
  set streak(int? value) => setField<int>('streak', value);
}
