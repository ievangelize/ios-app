import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/schema/structs/index.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

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
    _safeInit(() {
      _firstExplore = prefs.getBool('ff_firstExplore') ?? _firstExplore;
    });
    _safeInit(() {
      _openaiApiKey = prefs.getString('ff_openaiApiKey') ?? _openaiApiKey;
    });
    _safeInit(() {
      _deepgramApiKey = prefs.getString('ff_deepgramApiKey') ?? _deepgramApiKey;
    });
    _safeInit(() {
      _onboardingQuestions =
          prefs.getStringList('ff_onboardingQuestions')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _onboardingQuestions;
    });
    _safeInit(() {
      _onboardingComplete =
          prefs.getBool('ff_onboardingComplete') ?? _onboardingComplete;
    });
    _safeInit(() {
      _completeQuoteDay =
          prefs.getString('ff_completeQuoteDay') ?? _completeQuoteDay;
    });
    _safeInit(() {
      _activeDays = prefs.getStringList('ff_activeDays')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _activeDays;
    });
    _safeInit(() {
      _clickedDonate = prefs.getBool('ff_clickedDonate') ?? _clickedDonate;
    });
    _safeInit(() {
      _onboardingStarted =
          prefs.getBool('ff_onboardingStarted') ?? _onboardingStarted;
    });
    _safeInit(() {
      _firstSimulator = prefs.getBool('ff_firstSimulator') ?? _firstSimulator;
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

  bool _firstSituaton = true;
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

  String _fcmToken = '';
  String get fcmToken => _fcmToken;
  set fcmToken(String value) {
    _fcmToken = value;
  }

  /// first time opening explore page
  bool _firstExplore = true;
  bool get firstExplore => _firstExplore;
  set firstExplore(bool value) {
    _firstExplore = value;
    prefs.setBool('ff_firstExplore', value);
  }

  String _sst = '';
  String get sst => _sst;
  set sst(String value) {
    _sst = value;
  }

  String _openaiApiKey =
      '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';
  String get openaiApiKey => _openaiApiKey;
  set openaiApiKey(String value) {
    _openaiApiKey = value;
    prefs.setString('ff_openaiApiKey', value);
  }

  bool _isListening = false;
  bool get isListening => _isListening;
  set isListening(bool value) {
    _isListening = value;
  }

  String _recognizedText = '';
  String get recognizedText => _recognizedText;
  set recognizedText(String value) {
    _recognizedText = value;
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
  }

  String _appStateTranscription = '';
  String get appStateTranscription => _appStateTranscription;
  set appStateTranscription(String value) {
    _appStateTranscription = value;
  }

  bool _appStateIsListening = false;
  bool get appStateIsListening => _appStateIsListening;
  set appStateIsListening(bool value) {
    _appStateIsListening = value;
  }

  bool _appStateIsConnected = false;
  bool get appStateIsConnected => _appStateIsConnected;
  set appStateIsConnected(bool value) {
    _appStateIsConnected = value;
  }

  String _appStateCurrentChunk = '';
  String get appStateCurrentChunk => _appStateCurrentChunk;
  set appStateCurrentChunk(String value) {
    _appStateCurrentChunk = value;
  }

  String _appStateStatus = '';
  String get appStateStatus => _appStateStatus;
  set appStateStatus(String value) {
    _appStateStatus = value;
  }

  String _deepgramApiKey = '642028959a2ccaec785ba823acc0cfe00c8e81a1';
  String get deepgramApiKey => _deepgramApiKey;
  set deepgramApiKey(String value) {
    _deepgramApiKey = value;
    prefs.setString('ff_deepgramApiKey', value);
  }

  String _agentResponse = '';
  String get agentResponse => _agentResponse;
  set agentResponse(String value) {
    _agentResponse = value;
  }

  List<dynamic> _onboardingSnapshot = [];
  List<dynamic> get onboardingSnapshot => _onboardingSnapshot;
  set onboardingSnapshot(List<dynamic> value) {
    _onboardingSnapshot = value;
  }

  void addToOnboardingSnapshot(dynamic value) {
    onboardingSnapshot.add(value);
  }

  void removeFromOnboardingSnapshot(dynamic value) {
    onboardingSnapshot.remove(value);
  }

  void removeAtIndexFromOnboardingSnapshot(int index) {
    onboardingSnapshot.removeAt(index);
  }

  void updateOnboardingSnapshotAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    onboardingSnapshot[index] = updateFn(_onboardingSnapshot[index]);
  }

  void insertAtIndexInOnboardingSnapshot(int index, dynamic value) {
    onboardingSnapshot.insert(index, value);
  }

  List<dynamic> _onboardingQuestions = [
    jsonDecode(
        '{\"key\":\"gender\",\"question\":\"What’s your gender?\",\"answers\":[{\"id\":\"male\",\"label\":\"Male\"},{\"id\":\"female\",\"label\":\"Female\"}]}'),
    jsonDecode(
        '{\"key\":\"experience\",\"question\":\"How would you describe your evangelism experience?\",\"answers\":[{\"id\":\"never_shared\",\"label\":\"🐣  I’ve never shared before\"},{\"id\":\"tried_once_twice\",\"label\":\"🌱  I’ve only tried once or twice\"},{\"id\":\"share_sometimes\",\"label\":\"🔥  I share from time to time\"},{\"id\":\"share_regularly\",\"label\":\"💪  I share regularly\"}]}'),
    jsonDecode(
        '{\"key\":\"age_range\",\"question\":\"How old are you?\",\"answers\":[{\"id\":\"13_17\",\"label\":\"13 to 17\"},{\"id\":\"18_24\",\"label\":\"18 to 24\"},{\"id\":\"25_34\",\"label\":\"25 to 34\"},{\"id\":\"35_44\",\"label\":\"35 to 44\"},{\"id\":\"44_54\",\"label\":\"44 to 54\"},{\"id\":\"55_plus\",\"label\":\"55 or above\"}]}'),
    jsonDecode(
        '{\"key\":\"last_shared\",\"question\":\"When was the last time you shared the Gospel?\",\"answers\":[{\"id\":\"within_30d\",\"label\":\"📅   Within the last 30 days\"},{\"id\":\"dont_remember\",\"label\":\"🤔   I don’t remember\"},{\"id\":\"over_1_month\",\"label\":\"⏳   Over a month ago\"},{\"id\":\"never_shared\",\"label\":\"🐣   I’ve never shared before\"}]}'),
    jsonDecode(
        '{\"key\":\"prompted_but_silent\",\"question\":\"Have you ever felt prompted to evangelize, but stayed quiet?\",\"answers\":[{\"id\":\"yes\",\"label\":\"Yes\"},{\"id\":\"no\",\"label\":\"No\"}]}'),
    jsonDecode(
        '{\"key\":\"confidence_level\",\"question\":\"Do you feel confident answering questions about your faith?\",\"answers\":[{\"id\":\"not_confident\",\"label\":\"🤐   Not at all confident\"},{\"id\":\"little_confident\",\"label\":\"😬   A little confident, but nervous\"},{\"id\":\"somewhat_confident\",\"label\":\"🙂   Somewhat confident\"},{\"id\":\"very_confident\",\"label\":\"🔥   Very confident\"}]}'),
    jsonDecode(
        '{\"key\":\"regret_frequency\",\"question\":\"Have you ever regretted missing an opportunity to share Jesus?\",\"answers\":[{\"id\":\"never\",\"label\":\"❌   No, never\"},{\"id\":\"once_twice\",\"label\":\"🤔   Yes, once or twice\"},{\"id\":\"several\",\"label\":\"😞   Yes, several times\"},{\"id\":\"many\",\"label\":\"💔   Yes, more than I can count\"}]}'),
    jsonDecode(
        '{\"key\":\"urgency_view\",\"question\":\"Do you believe people around you urgently need to hear the Gospel?\",\"answers\":[{\"id\":\"yes_can_wait\",\"label\":\"😐   Yes, but they can wait\"},{\"id\":\"urgent\",\"label\":\"🔥   Absolutely, it’s urgent\"},{\"id\":\"not_sure\",\"label\":\"🤔   I’m not sure\"}]}')
  ];
  List<dynamic> get onboardingQuestions => _onboardingQuestions;
  set onboardingQuestions(List<dynamic> value) {
    _onboardingQuestions = value;
    prefs.setStringList(
        'ff_onboardingQuestions', value.map((x) => jsonEncode(x)).toList());
  }

  void addToOnboardingQuestions(dynamic value) {
    onboardingQuestions.add(value);
    prefs.setStringList('ff_onboardingQuestions',
        _onboardingQuestions.map((x) => jsonEncode(x)).toList());
  }

  void removeFromOnboardingQuestions(dynamic value) {
    onboardingQuestions.remove(value);
    prefs.setStringList('ff_onboardingQuestions',
        _onboardingQuestions.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromOnboardingQuestions(int index) {
    onboardingQuestions.removeAt(index);
    prefs.setStringList('ff_onboardingQuestions',
        _onboardingQuestions.map((x) => jsonEncode(x)).toList());
  }

  void updateOnboardingQuestionsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    onboardingQuestions[index] = updateFn(_onboardingQuestions[index]);
    prefs.setStringList('ff_onboardingQuestions',
        _onboardingQuestions.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInOnboardingQuestions(int index, dynamic value) {
    onboardingQuestions.insert(index, value);
    prefs.setStringList('ff_onboardingQuestions',
        _onboardingQuestions.map((x) => jsonEncode(x)).toList());
  }

  bool _onboardingBtn = false;
  bool get onboardingBtn => _onboardingBtn;
  set onboardingBtn(bool value) {
    _onboardingBtn = value;
  }

  List<dynamic> _onboardingKv = [];
  List<dynamic> get onboardingKv => _onboardingKv;
  set onboardingKv(List<dynamic> value) {
    _onboardingKv = value;
  }

  void addToOnboardingKv(dynamic value) {
    onboardingKv.add(value);
  }

  void removeFromOnboardingKv(dynamic value) {
    onboardingKv.remove(value);
  }

  void removeAtIndexFromOnboardingKv(int index) {
    onboardingKv.removeAt(index);
  }

  void updateOnboardingKvAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    onboardingKv[index] = updateFn(_onboardingKv[index]);
  }

  void insertAtIndexInOnboardingKv(int index, dynamic value) {
    onboardingKv.insert(index, value);
  }

  bool _onboardingComplete = false;
  bool get onboardingComplete => _onboardingComplete;
  set onboardingComplete(bool value) {
    _onboardingComplete = value;
    prefs.setBool('ff_onboardingComplete', value);
  }

  int _currentStreak = 0;
  int get currentStreak => _currentStreak;
  set currentStreak(int value) {
    _currentStreak = value;
  }

  List<String> _simulatorHistory = [];
  List<String> get simulatorHistory => _simulatorHistory;
  set simulatorHistory(List<String> value) {
    _simulatorHistory = value;
  }

  void addToSimulatorHistory(String value) {
    simulatorHistory.add(value);
  }

  void removeFromSimulatorHistory(String value) {
    simulatorHistory.remove(value);
  }

  void removeAtIndexFromSimulatorHistory(int index) {
    simulatorHistory.removeAt(index);
  }

  void updateSimulatorHistoryAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    simulatorHistory[index] = updateFn(_simulatorHistory[index]);
  }

  void insertAtIndexInSimulatorHistory(int index, String value) {
    simulatorHistory.insert(index, value);
  }

  String _completeQuoteDay = '';
  String get completeQuoteDay => _completeQuoteDay;
  set completeQuoteDay(String value) {
    _completeQuoteDay = value;
    prefs.setString('ff_completeQuoteDay', value);
  }

  List<dynamic> _activeDays = [];
  List<dynamic> get activeDays => _activeDays;
  set activeDays(List<dynamic> value) {
    _activeDays = value;
    prefs.setStringList(
        'ff_activeDays', value.map((x) => jsonEncode(x)).toList());
  }

  void addToActiveDays(dynamic value) {
    activeDays.add(value);
    prefs.setStringList(
        'ff_activeDays', _activeDays.map((x) => jsonEncode(x)).toList());
  }

  void removeFromActiveDays(dynamic value) {
    activeDays.remove(value);
    prefs.setStringList(
        'ff_activeDays', _activeDays.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromActiveDays(int index) {
    activeDays.removeAt(index);
    prefs.setStringList(
        'ff_activeDays', _activeDays.map((x) => jsonEncode(x)).toList());
  }

  void updateActiveDaysAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    activeDays[index] = updateFn(_activeDays[index]);
    prefs.setStringList(
        'ff_activeDays', _activeDays.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInActiveDays(int index, dynamic value) {
    activeDays.insert(index, value);
    prefs.setStringList(
        'ff_activeDays', _activeDays.map((x) => jsonEncode(x)).toList());
  }

  bool _firstHomeVisit = true;
  bool get firstHomeVisit => _firstHomeVisit;
  set firstHomeVisit(bool value) {
    _firstHomeVisit = value;
  }

  bool _clickedDonate = false;
  bool get clickedDonate => _clickedDonate;
  set clickedDonate(bool value) {
    _clickedDonate = value;
    prefs.setBool('ff_clickedDonate', value);
  }

  List<dynamic> _exploreUcpIdsJson = [];
  List<dynamic> get exploreUcpIdsJson => _exploreUcpIdsJson;
  set exploreUcpIdsJson(List<dynamic> value) {
    _exploreUcpIdsJson = value;
  }

  void addToExploreUcpIdsJson(dynamic value) {
    exploreUcpIdsJson.add(value);
  }

  void removeFromExploreUcpIdsJson(dynamic value) {
    exploreUcpIdsJson.remove(value);
  }

  void removeAtIndexFromExploreUcpIdsJson(int index) {
    exploreUcpIdsJson.removeAt(index);
  }

  void updateExploreUcpIdsJsonAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    exploreUcpIdsJson[index] = updateFn(_exploreUcpIdsJson[index]);
  }

  void insertAtIndexInExploreUcpIdsJson(int index, dynamic value) {
    exploreUcpIdsJson.insert(index, value);
  }

  List<MessageStruct> _messages = [];
  List<MessageStruct> get messages => _messages;
  set messages(List<MessageStruct> value) {
    _messages = value;
  }

  void addToMessages(MessageStruct value) {
    messages.add(value);
  }

  void removeFromMessages(MessageStruct value) {
    messages.remove(value);
  }

  void removeAtIndexFromMessages(int index) {
    messages.removeAt(index);
  }

  void updateMessagesAtIndex(
    int index,
    MessageStruct Function(MessageStruct) updateFn,
  ) {
    messages[index] = updateFn(_messages[index]);
  }

  void insertAtIndexInMessages(int index, MessageStruct value) {
    messages.insert(index, value);
  }

  List<String> _simulatorLogs = [];
  List<String> get simulatorLogs => _simulatorLogs;
  set simulatorLogs(List<String> value) {
    _simulatorLogs = value;
  }

  void addToSimulatorLogs(String value) {
    simulatorLogs.add(value);
  }

  void removeFromSimulatorLogs(String value) {
    simulatorLogs.remove(value);
  }

  void removeAtIndexFromSimulatorLogs(int index) {
    simulatorLogs.removeAt(index);
  }

  void updateSimulatorLogsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    simulatorLogs[index] = updateFn(_simulatorLogs[index]);
  }

  void insertAtIndexInSimulatorLogs(int index, String value) {
    simulatorLogs.insert(index, value);
  }

  bool _onboardingStarted = false;
  bool get onboardingStarted => _onboardingStarted;
  set onboardingStarted(bool value) {
    _onboardingStarted = value;
    prefs.setBool('ff_onboardingStarted', value);
  }

  bool _firstSimulator = true;
  bool get firstSimulator => _firstSimulator;
  set firstSimulator(bool value) {
    _firstSimulator = value;
    prefs.setBool('ff_firstSimulator', value);
  }

  final _homeCourseManager = FutureRequestManager<List<CoursesRow>>();
  Future<List<CoursesRow>> homeCourse({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CoursesRow>> Function() requestFn,
  }) =>
      _homeCourseManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearHomeCourseCache() => _homeCourseManager.clear();
  void clearHomeCourseCacheKey(String? uniqueKey) =>
      _homeCourseManager.clearRequest(uniqueKey);

  final _quoteManager = FutureRequestManager<List<QuotesRow>>();
  Future<List<QuotesRow>> quote({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<QuotesRow>> Function() requestFn,
  }) =>
      _quoteManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearQuoteCache() => _quoteManager.clear();
  void clearQuoteCacheKey(String? uniqueKey) =>
      _quoteManager.clearRequest(uniqueKey);

  final _encountersManager = FutureRequestManager<List<ReachedRow>>();
  Future<List<ReachedRow>> encounters({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ReachedRow>> Function() requestFn,
  }) =>
      _encountersManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearEncountersCache() => _encountersManager.clear();
  void clearEncountersCacheKey(String? uniqueKey) =>
      _encountersManager.clearRequest(uniqueKey);

  final _conversationHistoryManager =
      FutureRequestManager<List<SituationRow>>();
  Future<List<SituationRow>> conversationHistory({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<SituationRow>> Function() requestFn,
  }) =>
      _conversationHistoryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearConversationHistoryCache() => _conversationHistoryManager.clear();
  void clearConversationHistoryCacheKey(String? uniqueKey) =>
      _conversationHistoryManager.clearRequest(uniqueKey);

  final _simulatorFeedbackManager =
      FutureRequestManager<List<SimulatorFeedbackRow>>();
  Future<List<SimulatorFeedbackRow>> simulatorFeedback({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<SimulatorFeedbackRow>> Function() requestFn,
  }) =>
      _simulatorFeedbackManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearSimulatorFeedbackCache() => _simulatorFeedbackManager.clear();
  void clearSimulatorFeedbackCacheKey(String? uniqueKey) =>
      _simulatorFeedbackManager.clearRequest(uniqueKey);

  final _chatHistoryManager = FutureRequestManager<List<ConversationsRow>>();
  Future<List<ConversationsRow>> chatHistory({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ConversationsRow>> Function() requestFn,
  }) =>
      _chatHistoryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearChatHistoryCache() => _chatHistoryManager.clear();
  void clearChatHistoryCacheKey(String? uniqueKey) =>
      _chatHistoryManager.clearRequest(uniqueKey);

  final _experienceVideosManager =
      FutureRequestManager<List<ExperienceVideosRow>>();
  Future<List<ExperienceVideosRow>> experienceVideos({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ExperienceVideosRow>> Function() requestFn,
  }) =>
      _experienceVideosManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearExperienceVideosCache() => _experienceVideosManager.clear();
  void clearExperienceVideosCacheKey(String? uniqueKey) =>
      _experienceVideosManager.clearRequest(uniqueKey);

  final _userAssignedMissionsManager =
      FutureRequestManager<List<UserAssignedMissionsRow>>();
  Future<List<UserAssignedMissionsRow>> userAssignedMissions({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserAssignedMissionsRow>> Function() requestFn,
  }) =>
      _userAssignedMissionsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserAssignedMissionsCache() => _userAssignedMissionsManager.clear();
  void clearUserAssignedMissionsCacheKey(String? uniqueKey) =>
      _userAssignedMissionsManager.clearRequest(uniqueKey);

  final _tiersManager = FutureRequestManager<List<TiersRow>>();
  Future<List<TiersRow>> tiers({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TiersRow>> Function() requestFn,
  }) =>
      _tiersManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTiersCache() => _tiersManager.clear();
  void clearTiersCacheKey(String? uniqueKey) =>
      _tiersManager.clearRequest(uniqueKey);

  final _coursesManager = FutureRequestManager<List<CoursesRow>>();
  Future<List<CoursesRow>> courses({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CoursesRow>> Function() requestFn,
  }) =>
      _coursesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCoursesCache() => _coursesManager.clear();
  void clearCoursesCacheKey(String? uniqueKey) =>
      _coursesManager.clearRequest(uniqueKey);

  final _personasManager = FutureRequestManager<List<SimulatorPersonasRow>>();
  Future<List<SimulatorPersonasRow>> personas({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<SimulatorPersonasRow>> Function() requestFn,
  }) =>
      _personasManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPersonasCache() => _personasManager.clear();
  void clearPersonasCacheKey(String? uniqueKey) =>
      _personasManager.clearRequest(uniqueKey);
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
