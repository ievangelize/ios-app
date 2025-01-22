import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _viewedReached = prefs.getBool('ff_viewedReached') ?? _viewedReached;
    });
    _safeInit(() {
      _completedOnboarding =
          prefs.getBool('ff_completedOnboarding') ?? _completedOnboarding;
    });
    _safeInit(() {
      _madeNoAuthPrompt =
          prefs.getBool('ff_madeNoAuthPrompt') ?? _madeNoAuthPrompt;
    });
    _safeInit(() {
      _SupabaseKey = prefs.getString('ff_SupabaseKey') ?? _SupabaseKey;
    });
    _safeInit(() {
      _firstSituaton = prefs.getBool('ff_firstSituaton') ?? _firstSituaton;
    });
    _safeInit(() {
      _madeFirstImpact =
          prefs.getBool('ff_madeFirstImpact') ?? _madeFirstImpact;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _currentURL = '';
  String get currentURL => _currentURL;
  set currentURL(String value) {
    _currentURL = value;
  }

  bool _viewedReached = false;
  bool get viewedReached => _viewedReached;
  set viewedReached(bool value) {
    _viewedReached = value;
    prefs.setBool('ff_viewedReached', value);
  }

  bool _completedOnboarding = false;
  bool get completedOnboarding => _completedOnboarding;
  set completedOnboarding(bool value) {
    _completedOnboarding = value;
    prefs.setBool('ff_completedOnboarding', value);
  }

  bool _madeNoAuthPrompt = false;
  bool get madeNoAuthPrompt => _madeNoAuthPrompt;
  set madeNoAuthPrompt(bool value) {
    _madeNoAuthPrompt = value;
    prefs.setBool('ff_madeNoAuthPrompt', value);
  }

  String _SupabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ2b2Z6a3BieGp0am9maHBkY3V1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI4Nzk4OTUsImV4cCI6MjAyODQ1NTg5NX0.p7VWByVny8KrEJF_SXuTPVTtctCyMou7Bwxr2X4CszU';
  String get SupabaseKey => _SupabaseKey;
  set SupabaseKey(String value) {
    _SupabaseKey = value;
    prefs.setString('ff_SupabaseKey', value);
  }

  bool _firstSituaton = false;
  bool get firstSituaton => _firstSituaton;
  set firstSituaton(bool value) {
    _firstSituaton = value;
    prefs.setBool('ff_firstSituaton', value);
  }

  bool _madeFirstImpact = false;
  bool get madeFirstImpact => _madeFirstImpact;
  set madeFirstImpact(bool value) {
    _madeFirstImpact = value;
    prefs.setBool('ff_madeFirstImpact', value);
  }

  bool _joinedChurch = false;
  bool get joinedChurch => _joinedChurch;
  set joinedChurch(bool value) {
    _joinedChurch = value;
  }

  final _profileManager = FutureRequestManager<List<UsersRow>>();
  Future<List<UsersRow>> profile({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRow>> Function() requestFn,
  }) =>
      _profileManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProfileCache() => _profileManager.clear();
  void clearProfileCacheKey(String? uniqueKey) =>
      _profileManager.clearRequest(uniqueKey);

  final _lessonsManager = FutureRequestManager<List<LessonsRow>>();
  Future<List<LessonsRow>> lessons({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<LessonsRow>> Function() requestFn,
  }) =>
      _lessonsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearLessonsCache() => _lessonsManager.clear();
  void clearLessonsCacheKey(String? uniqueKey) =>
      _lessonsManager.clearRequest(uniqueKey);

  final _reachedManager = FutureRequestManager<List<ReachedRow>>();
  Future<List<ReachedRow>> reached({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ReachedRow>> Function() requestFn,
  }) =>
      _reachedManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearReachedCache() => _reachedManager.clear();
  void clearReachedCacheKey(String? uniqueKey) =>
      _reachedManager.clearRequest(uniqueKey);

  final _icebreakersManager = FutureRequestManager<List<SituationRow>>();
  Future<List<SituationRow>> icebreakers({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<SituationRow>> Function() requestFn,
  }) =>
      _icebreakersManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearIcebreakersCache() => _icebreakersManager.clear();
  void clearIcebreakersCacheKey(String? uniqueKey) =>
      _icebreakersManager.clearRequest(uniqueKey);

  final _icebreakerFavoriteManager = FutureRequestManager<List<SituationRow>>();
  Future<List<SituationRow>> icebreakerFavorite({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<SituationRow>> Function() requestFn,
  }) =>
      _icebreakerFavoriteManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearIcebreakerFavoriteCache() => _icebreakerFavoriteManager.clear();
  void clearIcebreakerFavoriteCacheKey(String? uniqueKey) =>
      _icebreakerFavoriteManager.clearRequest(uniqueKey);

  final _resourcesManager = FutureRequestManager<List<ResourcesRow>>();
  Future<List<ResourcesRow>> resources({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ResourcesRow>> Function() requestFn,
  }) =>
      _resourcesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearResourcesCache() => _resourcesManager.clear();
  void clearResourcesCacheKey(String? uniqueKey) =>
      _resourcesManager.clearRequest(uniqueKey);

  final _tagsManager = FutureRequestManager<List<FilterTagsRow>>();
  Future<List<FilterTagsRow>> tags({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<FilterTagsRow>> Function() requestFn,
  }) =>
      _tagsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTagsCache() => _tagsManager.clear();
  void clearTagsCacheKey(String? uniqueKey) =>
      _tagsManager.clearRequest(uniqueKey);

  final _categoriesManager = FutureRequestManager<List<CategoriesRow>>();
  Future<List<CategoriesRow>> categories({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CategoriesRow>> Function() requestFn,
  }) =>
      _categoriesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCategoriesCache() => _categoriesManager.clear();
  void clearCategoriesCacheKey(String? uniqueKey) =>
      _categoriesManager.clearRequest(uniqueKey);

  final _missionsManager = FutureRequestManager<List<MissionsRow>>();
  Future<List<MissionsRow>> missions({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<MissionsRow>> Function() requestFn,
  }) =>
      _missionsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearMissionsCache() => _missionsManager.clear();
  void clearMissionsCacheKey(String? uniqueKey) =>
      _missionsManager.clearRequest(uniqueKey);

  final _homeCategoriesManager = FutureRequestManager<List<CategoriesRow>>();
  Future<List<CategoriesRow>> homeCategories({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CategoriesRow>> Function() requestFn,
  }) =>
      _homeCategoriesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearHomeCategoriesCache() => _homeCategoriesManager.clear();
  void clearHomeCategoriesCacheKey(String? uniqueKey) =>
      _homeCategoriesManager.clearRequest(uniqueKey);

  final _noAuthMissionsManager = FutureRequestManager<List<NoAuthMissionRow>>();
  Future<List<NoAuthMissionRow>> noAuthMissions({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<NoAuthMissionRow>> Function() requestFn,
  }) =>
      _noAuthMissionsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearNoAuthMissionsCache() => _noAuthMissionsManager.clear();
  void clearNoAuthMissionsCacheKey(String? uniqueKey) =>
      _noAuthMissionsManager.clearRequest(uniqueKey);

  final _storyManager = FutureRequestManager<List<StoriesRow>>();
  Future<List<StoriesRow>> story({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<StoriesRow>> Function() requestFn,
  }) =>
      _storyManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearStoryCache() => _storyManager.clear();
  void clearStoryCacheKey(String? uniqueKey) =>
      _storyManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
