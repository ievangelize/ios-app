import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/supabase/supabase.dart';

import '/auth/base_auth_user_provider.dart';

import '/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

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
          appStateNotifier.loggedIn ? const HomeWidget() : const Quote1Widget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? const HomeWidget() : const Quote1Widget(),
          routes: [
            FFRoute(
              name: 'situation',
              path: 'situation',
              requireAuth: true,
              builder: (context, params) => const SituationWidget(),
            ),
            FFRoute(
              name: 'Signup',
              path: 'signup',
              builder: (context, params) => const SignupWidget(),
            ),
            FFRoute(
              name: 'Login',
              path: 'login',
              builder: (context, params) => const LoginWidget(),
            ),
            FFRoute(
              name: 'followUpAdd',
              path: 'followUpAdd',
              requireAuth: true,
              builder: (context, params) => const FollowUpAddWidget(),
            ),
            FFRoute(
              name: 'followUpUpdate',
              path: 'followUpUpdate',
              requireAuth: true,
              builder: (context, params) => FollowUpUpdateWidget(
                selectedPerson: params.getParam<ReachedRow>(
                  'selectedPerson',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'IcebreakersList',
              path: 'icebreakersList',
              builder: (context, params) => const IcebreakersListWidget(),
            ),
            FFRoute(
              name: 'LessonsList',
              path: 'lessonsList',
              builder: (context, params) => const LessonsListWidget(),
            ),
            FFRoute(
              name: 'More',
              path: 'more',
              builder: (context, params) => const MoreWidget(),
            ),
            FFRoute(
              name: 'Account',
              path: 'account',
              requireAuth: true,
              builder: (context, params) => AccountWidget(
                account: params.getParam<UsersRow>(
                  'account',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'Languages',
              path: 'languages',
              builder: (context, params) => const LanguagesWidget(),
            ),
            FFRoute(
              name: 'EditProfile',
              path: 'editProfile',
              requireAuth: true,
              builder: (context, params) => EditProfileWidget(
                account: params.getParam<UsersRow>(
                  'account',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'UpdateEmail',
              path: 'updateEmail',
              requireAuth: true,
              builder: (context, params) => UpdateEmailWidget(
                account: params.getParam<UsersRow>(
                  'account',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'authentication',
              path: 'authentication',
              builder: (context, params) => const AuthenticationWidget(),
            ),
            FFRoute(
              name: 'EmailUpdated',
              path: 'email-updated',
              builder: (context, params) => EmailUpdatedWidget(
                account: params.getParam<UsersRow>(
                  'account',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'About',
              path: 'about',
              builder: (context, params) => const AboutWidget(),
            ),
            FFRoute(
              name: 'AudioPlayer',
              path: 'audioplayer',
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
              name: 'emailSent',
              path: 'emailSent',
              builder: (context, params) => const EmailSentWidget(),
            ),
            FFRoute(
              name: 'NewSituation',
              path: 'newui',
              builder: (context, params) => NewSituationWidget(
                gptAnswer: params.getParam(
                  'gptAnswer',
                  ParamType.JSON,
                ),
                newSituation: params.getParam<SituationRow>(
                  'newSituation',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'followUpList',
              path: 'followUp',
              builder: (context, params) => const FollowUpListWidget(),
            ),
            FFRoute(
              name: 'selectedSituation',
              path: 'newui2',
              builder: (context, params) => SelectedSituationWidget(
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
              name: 'home',
              path: 'home',
              requireAuth: true,
              builder: (context, params) => const HomeWidget(),
            ),
            FFRoute(
              name: 'donate',
              path: 'donate',
              builder: (context, params) => const DonateWidget(),
            ),
            FFRoute(
              name: 'PayitForward',
              path: 'payitForward',
              builder: (context, params) => const PayitForwardWidget(),
            ),
            FFRoute(
              name: 'Explore',
              path: 'explore',
              builder: (context, params) => const ExploreWidget(),
            ),
            FFRoute(
              name: 'VerticalVideoPlayer',
              path: 'verticalVideoPlayer',
              builder: (context, params) => VerticalVideoPlayerWidget(
                videoURL: params.getParam(
                  'videoURL',
                  ParamType.String,
                ),
                title: params.getParam(
                  'title',
                  ParamType.String,
                ),
                description: params.getParam(
                  'description',
                  ParamType.String,
                ),
                shareURL: params.getParam(
                  'shareURL',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: 'CategoryHorizontal',
              path: 'categoryHorizontal',
              builder: (context, params) => CategoryHorizontalWidget(
                category: params.getParam<CategoriesRow>(
                  'category',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'CategoryVertical',
              path: 'categoryVertical',
              builder: (context, params) => CategoryVerticalWidget(
                category: params.getParam<CategoriesRow>(
                  'category',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'StoryViewer',
              path: 'storyViewer',
              builder: (context, params) => StoryViewerWidget(
                story: params.getParam<StoriesRow>(
                  'story',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'AddImpact',
              path: 'addImpact',
              builder: (context, params) => AddImpactWidget(
                gospelShares: params.getParam(
                  'gospelShares',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: 'RecordInfoChoice',
              path: 'recordInfoChoice',
              builder: (context, params) => const RecordInfoChoiceWidget(),
            ),
            FFRoute(
              name: 'HorizontalVideoPlayer',
              path: 'horizontalVideoPlayer',
              builder: (context, params) => HorizontalVideoPlayerWidget(
                title: params.getParam(
                  'title',
                  ParamType.String,
                ),
                description: params.getParam(
                  'description',
                  ParamType.String,
                ),
                videoURL: params.getParam(
                  'videoURL',
                  ParamType.String,
                ),
                providerID: params.getParam(
                  'providerID',
                  ParamType.int,
                ),
                shareURL: params.getParam(
                  'shareURL',
                  ParamType.String,
                ),
                categoryTitle: params.getParam(
                  'categoryTitle',
                  ParamType.String,
                ),
                categoryThumbnail: params.getParam(
                  'categoryThumbnail',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: 'ResourceCredit',
              path: 'resourceCredit',
              builder: (context, params) => ResourceCreditWidget(
                provider: params.getParam<ResourceProvidersRow>(
                  'provider',
                  ParamType.SupabaseRow,
                ),
              ),
            ),
            FFRoute(
              name: 'SearchResults',
              path: 'search-results',
              builder: (context, params) => SearchResultsWidget(
                initialSearch: params.getParam(
                  'initialSearch',
                  ParamType.String,
                ),
                initialChoiceChip: params.getParam(
                  'initialChoiceChip',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: 'getStarted',
              path: 'getStarted',
              builder: (context, params) => const GetStartedWidget(),
            ),
            FFRoute(
              name: 'quote1',
              path: 'quote1',
              builder: (context, params) => const Quote1Widget(),
            ),
            FFRoute(
              name: 'quote2',
              path: 'quote2',
              builder: (context, params) => const Quote2Widget(),
            ),
            FFRoute(
              name: 'quote3',
              path: 'quote3',
              builder: (context, params) => const Quote3Widget(),
            ),
            FFRoute(
              name: 'Impact',
              path: 'impact',
              builder: (context, params) => ImpactWidget(
                shares: params.getParam(
                  'shares',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: 'homeNoAuth',
              path: 'homeNoAuth',
              builder: (context, params) => const HomeNoAuthWidget(),
            ),
            FFRoute(
              name: 'situationNoAuth',
              path: 'situationnoauth',
              builder: (context, params) => const SituationNoAuthWidget(),
            ),
            FFRoute(
              name: 'followUpNoAuth',
              path: 'followupNoAuth',
              builder: (context, params) => const FollowUpNoAuthWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
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
            return '/quote1';
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
                  color: FlutterFlowTheme.of(context).secondary,
                  child: Center(
                    child: Image.asset(
                      'assets/images/App_Splash_Icon.png',
                      width: 288.0,
                      height: 288.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
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

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
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
