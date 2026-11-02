import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/supabase/supabase.dart';

import '/auth/base_auth_user_provider.dart';

import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? MainHomeWidget() : WelcomeWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? MainHomeWidget() : WelcomeWidget(),
          routes: [
            FFRoute(
              name: SignupWidget.routeName,
              path: SignupWidget.routePath,
              builder: (context, params) => SignupWidget(),
            ),
            FFRoute(
              name: LoginWidget.routeName,
              path: LoginWidget.routePath,
              builder: (context, params) => LoginWidget(),
            ),
            FFRoute(
              name: ProfileEditWidget.routeName,
              path: ProfileEditWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ProfileEditWidget(
                profile: params.getParam<UsersRow>(
                  'profile',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: AboutWidget.routeName,
              path: AboutWidget.routePath,
              requireAuth: true,
              builder: (context, params) => AboutWidget(),
            ),
            FFRoute(
              name: AudioPlayerWidget.routeName,
              path: AudioPlayerWidget.routePath,
              requireAuth: true,
              builder: (context, params) => AudioPlayerWidget(
                title: params.getParam(
                  'title',
                  ParamType.String,
                ),
                thumbnailURL: params.getParam(
                  'thumbnailURL',
                  ParamType.String,
                ),
                subTitle: params.getParam(
                  'subTitle',
                  ParamType.String,
                ),
                audioURL: params.getParam(
                  'audioURL',
                  ParamType.String,
                ),
                shareURL: params.getParam(
                  'shareURL',
                  ParamType.String,
                ),
                providerID: params.getParam(
                  'providerID',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: SelectedStarterWidget.routeName,
              path: SelectedStarterWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SelectedStarterWidget(
                gptAnswer: params.getParam(
                  'gptAnswer',
                  ParamType.JSON,
                ),
                selectedSituation: params.getParam<SituationRow>(
                  'selectedSituation',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: DonateWidget.routeName,
              path: DonateWidget.routePath,
              requireAuth: true,
              builder: (context, params) => DonateWidget(),
            ),
            FFRoute(
              name: VerticalVideoPlayerWidget.routeName,
              path: VerticalVideoPlayerWidget.routePath,
              requireAuth: true,
              builder: (context, params) => VerticalVideoPlayerWidget(
                lesson: params.getParam<CourseLessonsRow>(
                  'lesson',
                  ParamType.SupabaseRow,
                ),
                courseName: params.getParam(
                  'courseName',
                  ParamType.String,
                ),
                course: params.getParam<CoursesRow>(
                  'course',
                  ParamType.SupabaseRow,
                ),
                resource: params.getParam<ResourcesRow>(
                  'resource',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: DailyQuoteWidget.routeName,
              path: DailyQuoteWidget.routePath,
              requireAuth: true,
              builder: (context, params) => DailyQuoteWidget(
                quote: params.getParam<QuotesRow>(
                  'quote',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: HorizontalVideoPlayerWidget.routeName,
              path: HorizontalVideoPlayerWidget.routePath,
              requireAuth: true,
              builder: (context, params) => HorizontalVideoPlayerWidget(
                lesson: params.getParam<CourseLessonsRow>(
                  'lesson',
                  ParamType.SupabaseRow,
                ),
                courseName: params.getParam(
                  'courseName',
                  ParamType.String,
                ),
                course: params.getParam<CoursesRow>(
                  'course',
                  ParamType.SupabaseRow,
                ),
                resource: params.getParam<ResourcesRow>(
                  'resource',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: ResourceCreditWidget.routeName,
              path: ResourceCreditWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ResourceCreditWidget(
                provider: params.getParam<ResourceProvidersRow>(
                  'provider',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: EquippingCardWidget.routeName,
              path: EquippingCardWidget.routePath,
              requireAuth: true,
              builder: (context, params) => EquippingCardWidget(),
            ),
            FFRoute(
              name: EquippingCardInfoWidget.routeName,
              path: EquippingCardInfoWidget.routePath,
              requireAuth: true,
              builder: (context, params) => EquippingCardInfoWidget(),
            ),
            FFRoute(
              name: ConversationStartersWidget.routeName,
              path: ConversationStartersWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ConversationStartersWidget(
                gptAnswer: params.getParam(
                  'gptAnswer',
                  ParamType.JSON,
                ),
              ),
            ),
            FFRoute(
              name: NewEncounterWidget.routeName,
              path: NewEncounterWidget.routePath,
              requireAuth: true,
              builder: (context, params) => NewEncounterWidget(),
            ),
            FFRoute(
              name: PickPersonaWidget.routeName,
              path: PickPersonaWidget.routePath,
              requireAuth: true,
              builder: (context, params) => PickPersonaWidget(),
            ),
            FFRoute(
              name: FeedbackWidget.routeName,
              path: FeedbackWidget.routePath,
              requireAuth: true,
              builder: (context, params) => FeedbackWidget(
                chatFeedback: params.getParam(
                  'chatFeedback',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: SimulatorAnalysisWidget.routeName,
              path: SimulatorAnalysisWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SimulatorAnalysisWidget(
                persona: params.getParam<SimulatorPersonasRow>(
                  'persona',
                  ParamType.SupabaseRow,
                ),
                duration: params.getParam(
                  'duration',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: CommitmentWidget.routeName,
              path: CommitmentWidget.routePath,
              builder: (context, params) => CommitmentWidget(),
            ),
            FFRoute(
              name: OnboardingAnalyzingWidget.routeName,
              path: OnboardingAnalyzingWidget.routePath,
              requireAuth: true,
              builder: (context, params) => OnboardingAnalyzingWidget(),
            ),
            FFRoute(
              name: AuthOnboardWidget.routeName,
              path: AuthOnboardWidget.routePath,
              builder: (context, params) => AuthOnboardWidget(),
            ),
            FFRoute(
              name: CourseWidget.routeName,
              path: CourseWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CourseWidget(
                course: params.getParam<CoursesRow>(
                  'course',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: LessonWidget.routeName,
              path: LessonWidget.routePath,
              requireAuth: true,
              builder: (context, params) => LessonWidget(
                lesson: params.getParam<CourseLessonsRow>(
                  'lesson',
                  ParamType.SupabaseRow,
                ),
                courseName: params.getParam(
                  'courseName',
                  ParamType.String,
                ),
                noPages: params.getParam(
                  'noPages',
                  ParamType.int,
                ),
                course: params.getParam<CoursesRow>(
                  'course',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: LessonCompleteWidget.routeName,
              path: LessonCompleteWidget.routePath,
              requireAuth: true,
              builder: (context, params) => LessonCompleteWidget(
                lessonXp: params.getParam(
                  'lessonXp',
                  ParamType.int,
                ),
                course: params.getParam<CoursesRow>(
                  'course',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: GrowWidget.routeName,
              path: GrowWidget.routePath,
              requireAuth: true,
              builder: (context, params) => GrowWidget(),
            ),
            FFRoute(
              name: NewMissionWidget.routeName,
              path: NewMissionWidget.routePath,
              requireAuth: true,
              builder: (context, params) => NewMissionWidget(
                mission: params.getParam<MissionsCatalogRow>(
                  'mission',
                  ParamType.SupabaseRow,
                ),
                lessonXp: params.getParam(
                  'lessonXp',
                  ParamType.int,
                ),
                target: params.getParam(
                  'target',
                  ParamType.String,
                ),
                course: params.getParam<CoursesRow>(
                  'course',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: EncounterCompleteWidget.routeName,
              path: EncounterCompleteWidget.routePath,
              requireAuth: true,
              builder: (context, params) => EncounterCompleteWidget(
                encounterXp: params.getParam(
                  'encounterXp',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: EncounterUpdateWidget.routeName,
              path: EncounterUpdateWidget.routePath,
              requireAuth: true,
              builder: (context, params) => EncounterUpdateWidget(
                seletedEncounter: params.getParam<ReachedRow>(
                  'seletedEncounter',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: CourseCompleteWidget.routeName,
              path: CourseCompleteWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CourseCompleteWidget(
                lessonXp: params.getParam(
                  'lessonXp',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: MissionCompleteWidget.routeName,
              path: MissionCompleteWidget.routePath,
              requireAuth: true,
              builder: (context, params) => MissionCompleteWidget(
                missionXp: params.getParam(
                  'missionXp',
                  ParamType.int,
                ),
                missionTitle: params.getParam(
                  'missionTitle',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: WelcomeWidget.routeName,
              path: WelcomeWidget.routePath,
              builder: (context, params) => WelcomeWidget(),
            ),
            FFRoute(
              name: ConversationAnalysisWidget.routeName,
              path: ConversationAnalysisWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ConversationAnalysisWidget(
                situation: params.getParam(
                  'situation',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: ConfirmOTPWidget.routeName,
              path: ConfirmOTPWidget.routePath,
              builder: (context, params) => ConfirmOTPWidget(
                email: params.getParam(
                  'email',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: EnterEmailWidget.routeName,
              path: EnterEmailWidget.routePath,
              builder: (context, params) => EnterEmailWidget(),
            ),
            FFRoute(
              name: VerticalVideoPlayerXpWidget.routeName,
              path: VerticalVideoPlayerXpWidget.routePath,
              requireAuth: true,
              builder: (context, params) => VerticalVideoPlayerXpWidget(
                video: params.getParam<ExperienceVideosRow>(
                  'video',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: EnterEmailAuthWidget.routeName,
              path: EnterEmailAuthWidget.routePath,
              builder: (context, params) => EnterEmailAuthWidget(),
            ),
            FFRoute(
              name: ConfirmOTPAuthWidget.routeName,
              path: ConfirmOTPAuthWidget.routePath,
              builder: (context, params) => ConfirmOTPAuthWidget(
                email: params.getParam(
                  'email',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: SelectedFeedbackWidget.routeName,
              path: SelectedFeedbackWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SelectedFeedbackWidget(
                feedback: params.getParam<SimulatorFeedbackRow>(
                  'feedback',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: MicPermissionWidget.routeName,
              path: MicPermissionWidget.routePath,
              requireAuth: true,
              builder: (context, params) => MicPermissionWidget(),
            ),
            FFRoute(
              name: SimulatorHistoryWidget.routeName,
              path: SimulatorHistoryWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SimulatorHistoryWidget(),
            ),
            FFRoute(
              name: UpdateVersionWidget.routeName,
              path: UpdateVersionWidget.routePath,
              builder: (context, params) => UpdateVersionWidget(),
            ),
            FFRoute(
              name: SituationWidget.routeName,
              path: SituationWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SituationWidget(),
            ),
            FFRoute(
              name: SettingsWidget.routeName,
              path: SettingsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SettingsWidget(
                pushAllowed: params.getParam(
                  'pushAllowed',
                  ParamType.bool,
                ),
              ),
            ),
            FFRoute(
              name: ConversationHistoryWidget.routeName,
              path: ConversationHistoryWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ConversationHistoryWidget(),
            ),
            FFRoute(
              name: CampaignDetailWidget.routeName,
              path: CampaignDetailWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CampaignDetailWidget(
                campaign: params.getParam<CampaignsRow>(
                  'campaign',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: GroupDetailWidget.routeName,
              path: GroupDetailWidget.routePath,
              requireAuth: true,
              builder: (context, params) => GroupDetailWidget(
                group: params.getParam<GroupsRow>(
                  'group',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: JoinGroupWidget.routeName,
              path: JoinGroupWidget.routePath,
              requireAuth: true,
              builder: (context, params) => JoinGroupWidget(),
            ),
            FFRoute(
              name: JoinCampaignWidget.routeName,
              path: JoinCampaignWidget.routePath,
              requireAuth: true,
              builder: (context, params) => JoinCampaignWidget(),
            ),
            FFRoute(
              name: NewEncounterCampaignWidget.routeName,
              path: NewEncounterCampaignWidget.routePath,
              requireAuth: true,
              builder: (context, params) => NewEncounterCampaignWidget(
                campaign: params.getParam<CampaignsRow>(
                  'campaign',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: UpdateEncounterCampaignWidget.routeName,
              path: UpdateEncounterCampaignWidget.routePath,
              requireAuth: true,
              builder: (context, params) => UpdateEncounterCampaignWidget(
                campaign: params.getParam<CampaignsRow>(
                  'campaign',
                  ParamType.SupabaseRow,
                ),
                encounter: params.getParam<ReachedRow>(
                  'encounter',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: AddFriendWidget.routeName,
              path: AddFriendWidget.routePath,
              requireAuth: true,
              builder: (context, params) => AddFriendWidget(
                user: params.getParam<UsersRow>(
                  'user',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: NewFriendCongratsWidget.routeName,
              path: NewFriendCongratsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => NewFriendCongratsWidget(),
            ),
            FFRoute(
              name: QuizWidget.routeName,
              path: QuizWidget.routePath,
              builder: (context, params) => QuizWidget(),
            ),
            FFRoute(
              name: ReviewsWidget.routeName,
              path: ReviewsWidget.routePath,
              builder: (context, params) => ReviewsWidget(),
            ),
            FFRoute(
              name: FriendsAddWidget.routeName,
              path: FriendsAddWidget.routePath,
              builder: (context, params) => FriendsAddWidget(),
            ),
            FFRoute(
              name: SimulatorFeatureWidget.routeName,
              path: SimulatorFeatureWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SimulatorFeatureWidget(),
            ),
            FFRoute(
              name: EncountersFeatureWidget.routeName,
              path: EncountersFeatureWidget.routePath,
              requireAuth: true,
              builder: (context, params) => EncountersFeatureWidget(),
            ),
            FFRoute(
              name: MissionsFeatureWidget.routeName,
              path: MissionsFeatureWidget.routePath,
              requireAuth: true,
              builder: (context, params) => MissionsFeatureWidget(),
            ),
            FFRoute(
              name: IcebreakerFeatureWidget.routeName,
              path: IcebreakerFeatureWidget.routePath,
              requireAuth: true,
              builder: (context, params) => IcebreakerFeatureWidget(),
            ),
            FFRoute(
              name: NotificationsWidget.routeName,
              path: NotificationsWidget.routePath,
              builder: (context, params) => NotificationsWidget(),
            ),
            FFRoute(
              name: SelectCampaignWidget.routeName,
              path: SelectCampaignWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SelectCampaignWidget(),
            ),
            FFRoute(
              name: NewSimulatorWidget.routeName,
              path: NewSimulatorWidget.routePath,
              requireAuth: true,
              builder: (context, params) => NewSimulatorWidget(
                persona: params.getParam<SimulatorPersonasRow>(
                  'persona',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: NewPrayerItemWidget.routeName,
              path: NewPrayerItemWidget.routePath,
              requireAuth: true,
              builder: (context, params) => NewPrayerItemWidget(),
            ),
            FFRoute(
              name: TargetInfoWidget.routeName,
              path: TargetInfoWidget.routePath,
              requireAuth: true,
              builder: (context, params) => TargetInfoWidget(
                target: params.getParam<PrayerTargetsRow>(
                  'target',
                  ParamType.SupabaseRow,
                ),
                viewing: params.getParam(
                  'viewing',
                  ParamType.bool,
                ),
              ),
            ),
            FFRoute(
              name: UpdatePrayerItemWidget.routeName,
              path: UpdatePrayerItemWidget.routePath,
              requireAuth: true,
              builder: (context, params) => UpdatePrayerItemWidget(
                target: params.getParam<PrayerTargetsRow>(
                  'target',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: PrayerWidget.routeName,
              path: PrayerWidget.routePath,
              builder: (context, params) => PrayerWidget(
                target: params.getParam<PrayerTargetsRow>(
                  'target',
                  ParamType.SupabaseRow,
                ),
                user: params.getParam<UsersRow>(
                  'user',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: PrePrayerWidget.routeName,
              path: PrePrayerWidget.routePath,
              builder: (context, params) => PrePrayerWidget(),
            ),
            FFRoute(
              name: PrayerCompleteWidget.routeName,
              path: PrayerCompleteWidget.routePath,
              requireAuth: true,
              builder: (context, params) => PrayerCompleteWidget(
                encounterXp: params.getParam(
                  'encounterXp',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: PrayerIntroWidget.routeName,
              path: PrayerIntroWidget.routePath,
              builder: (context, params) => PrayerIntroWidget(),
            ),
            FFRoute(
              name: PrayerNewTargetOnboardingWidget.routeName,
              path: PrayerNewTargetOnboardingWidget.routePath,
              requireAuth: true,
              builder: (context, params) => PrayerNewTargetOnboardingWidget(),
            ),
            FFRoute(
              name: PrayerQuoteWidget.routeName,
              path: PrayerQuoteWidget.routePath,
              requireAuth: true,
              builder: (context, params) => PrayerQuoteWidget(
                target: params.getParam<PrayerTargetsRow>(
                  'target',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: PrayerHowItWorksWidget.routeName,
              path: PrayerHowItWorksWidget.routePath,
              builder: (context, params) => PrayerHowItWorksWidget(
                target: params.getParam<PrayerTargetsRow>(
                  'target',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: FriendsIntroWidget.routeName,
              path: FriendsIntroWidget.routePath,
              builder: (context, params) => FriendsIntroWidget(),
            ),
            FFRoute(
              name: AdminQuestionWidget.routeName,
              path: AdminQuestionWidget.routePath,
              builder: (context, params) => AdminQuestionWidget(),
            ),
            FFRoute(
              name: AdminNameWidget.routeName,
              path: AdminNameWidget.routePath,
              builder: (context, params) => AdminNameWidget(),
            ),
            FFRoute(
              name: AdminGroupsInfoWidget.routeName,
              path: AdminGroupsInfoWidget.routePath,
              builder: (context, params) => AdminGroupsInfoWidget(),
            ),
            FFRoute(
              name: AdminTeamContactWidget.routeName,
              path: AdminTeamContactWidget.routePath,
              builder: (context, params) => AdminTeamContactWidget(),
            ),
            FFRoute(
              name: MainHomeWidget.routeName,
              path: MainHomeWidget.routePath,
              requireAuth: true,
              builder: (context, params) => MainHomeWidget(
                tabIndex: params.getParam(
                  'tabIndex',
                  ParamType.int,
                ),
                scrollToCourseId: params.getParam(
                  'scrollToCourseId',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: PathwayFeatureWidget.routeName,
              path: PathwayFeatureWidget.routePath,
              requireAuth: true,
              builder: (context, params) => PathwayFeatureWidget(),
            ),
            FFRoute(
              name: TargetSavedWidget.routeName,
              path: TargetSavedWidget.routePath,
              requireAuth: true,
              builder: (context, params) => TargetSavedWidget(
                lessonXp: params.getParam(
                  'lessonXp',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: FriendPrayerListWidget.routeName,
              path: FriendPrayerListWidget.routePath,
              requireAuth: true,
              builder: (context, params) => FriendPrayerListWidget(
                friend: params.getParam<UsersRow>(
                  'friend',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: EncounterInfoWidget.routeName,
              path: EncounterInfoWidget.routePath,
              requireAuth: true,
              builder: (context, params) => EncounterInfoWidget(
                encounter: params.getParam<ReachedRow>(
                  'encounter',
                  ParamType.SupabaseRow,
                ),
              ),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: ffNavigatorObservers,
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/welcome';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/white_splash.png',
                    fit: BoxFit.cover,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    curve: transitionInfo.transitionType ==
                            PageTransitionType.scale
                        ? const Interval(0.0, 0.5)
                        : Curves.linear,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
