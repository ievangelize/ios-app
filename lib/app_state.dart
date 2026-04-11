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
    _safeInit(() {
      _activityReactions =
          prefs.getStringList('ff_activityReactions') ?? _activityReactions;
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
        '{\"key\":\"age_range\",\"question\":\"How old are you?\",\"answers\":[{\"id\":\"13_17\",\"label\":\"13 to 17\"},{\"id\":\"18_24\",\"label\":\"18 to 24\"},{\"id\":\"25_34\",\"label\":\"25 to 34\"},{\"id\":\"35_44\",\"label\":\"35 to 44\"},{\"id\":\"44_54\",\"label\":\"44 to 54\"},{\"id\":\"55_plus\",\"label\":\"55 or above\"}]}'),
    jsonDecode(
        '{\"key\":\"gender\",\"question\":\"What’s your gender?\",\"answers\":[{\"id\":\"male\",\"label\":\"Male\"},{\"id\":\"female\",\"label\":\"Female\"}]}'),
    jsonDecode(
        '{\"key\":\"experience\",\"question\":\"How would you describe your evangelism experience?\",\"answers\":[{\"id\":\"never_shared\",\"label\":\"🐣  I’ve never shared before\"},{\"id\":\"tried_once_twice\",\"label\":\"🌱  I’ve only tried once or twice\"},{\"id\":\"share_sometimes\",\"label\":\"🔥  I share from time to time\"},{\"id\":\"share_regularly\",\"label\":\"💪  I share regularly\"}]}'),
    jsonDecode(
        '{\"key\":\"last_shared\",\"question\":\"When was the last time you shared the Gospel?\",\"answers\":[{\"id\":\"last_7_days\",\"label\":\"🎯  Within the last 7 days\"},{\"id\":\"last_30_days\",\"label\":\"📅  Within the last 30 days\"},{\"id\":\"over_month\",\"label\":\"⏳  Over a month ago\"},{\"id\":\"never\",\"label\":\"🐣   I’ve never shared\"}]}'),
    jsonDecode(
        '{\"key\":\"shared_last_3_months\",\"question\":\"In the past 3 months, how many people have you personally shared the Gospel with?\",\"answers\":[{\"id\":\"0\",\"label\":\"😬  0\"},{\"id\":\"1_5\",\"label\":\"👍  1 – 5\"},{\"id\":\"6_10\",\"label\":\"💪  6 - 10\"},{\"id\":\"10_plus\",\"label\":\"🎉  10+\"}]}'),
    jsonDecode(
        '{\"key\":\"led_to_christ_lifetime\",\"question\":\"In your life, how many people have you led to Christ in a face-to-face conversation?\",\"answers\":[{\"id\":\"0\",\"label\":\"None\"},{\"id\":\"1_10\",\"label\":\"1 - 10\"},{\"id\":\"11_30\",\"label\":\"11 - 30\"},{\"id\":\"31_69\",\"label\":\"31 - 69\"},{\"id\":\"70_99\",\"label\":\"70 - 99\"},{\"id\":\"100_plus\",\"label\":\"100+\"}]}'),
    jsonDecode(
        '{\"key\":\"unsaved_circle\",\"question\":\"Do you have close friends or family who don’t follow Jesus?\",\"answers\":[{\"id\":\"many\",\"label\":\"👨‍👩‍👧‍👦  Yes, many\"},{\"id\":\"few\",\"label\":\"👥  Yes, a few\"},{\"id\":\"one_two\",\"label\":\"🤏  Maybe 1–2\"},{\"id\":\"none\",\"label\":\"👍  Not really\"}]}'),
    jsonDecode(
        '{\"key\":\"shared_with_them\",\"question\":\"Have you shared the Gospel with them?\",\"answers\":[{\"id\":\"yes_clearly\",\"label\":\"✅  Yes, both verbally and by the way I live\"},{\"id\":\"hinted\",\"label\":\"🤔   I’ve hinted at it\"},{\"id\":\"thought_about\",\"label\":\"🤷   I’ve thought about it\"},{\"id\":\"no\",\"label\":\"❌  No\"}]}'),
    jsonDecode(
        '{\"key\":\"prompted_but_silent\",\"question\":\"Have you ever felt prompted to evangelize, but stayed quiet?\",\"answers\":[{\"id\":\"yes\",\"label\":\"Yes\"},{\"id\":\"no\",\"label\":\"No\"}]}'),
    jsonDecode(
        '{\"key\":\"regret_not_sharing\",\"question\":\"Have you ever regretted not sharing the Gospel?\",\"answers\":[{\"id\":\"never\",\"label\":\"❌  No\"},{\"id\":\"once_twice\",\"label\":\"🤔  Once or twice\"},{\"id\":\"several\",\"label\":\"😞  Several times\"},{\"id\":\"many\",\"label\":\"💔  Many times\"}]}'),
    jsonDecode(
        '{\"key\":\"confidence_explaining\",\"question\":\"How confident are you explaining the Gospel clearly?\",\"answers\":[{\"id\":\"not_confident\",\"label\":\"❌   Not at all\"},{\"id\":\"little_confident\",\"label\":\"🤷   A little\"},{\"id\":\"somewhat_confident\",\"label\":\"🙂  Somewhat\"},{\"id\":\"very_confident\",\"label\":\"🔥  Very confident\"}]}'),
    jsonDecode(
        '{\"key\":\"handle_objections\",\"question\":\"If someone challenged your faith, how would you respond?\",\"answers\":[{\"id\":\"dont_know\",\"label\":\"🏃  I wouldn’t know what to say\"},{\"id\":\"unsure\",\"label\":\"👀  I’d try but feel unsure\"},{\"id\":\"somewhat\",\"label\":\"🤔  I could respond somewhat\"},{\"id\":\"equipped\",\"label\":\"✅  I feel equipped\"}]}'),
    jsonDecode(
        '{\"key\":\"practice_sharing\",\"question\":\"Have you ever practiced sharing the Gospel?\",\"answers\":[{\"id\":\"yes\",\"label\":\"Yes\"},{\"id\":\"no\",\"label\":\"No\"}]}'),
    jsonDecode(
        '{\"key\":\"urgency_belief\",\"question\":\"Do you believe people around you urgently need the Gospel?\",\"answers\":[{\"id\":\"not_really\",\"label\":\"😐  Not really\"},{\"id\":\"not_sure\",\"label\":\"🤷  Honestly, I’m not sure\"},{\"id\":\"yes\",\"label\":\"💯  Yes\"}]}'),
    jsonDecode(
        '{\"key\":\"eternity_thought\",\"question\":\"How often do you think about the eternal destiny of people around you?\",\"answers\":[{\"id\":\"never\",\"label\":\"Never\"},{\"id\":\"rarely\",\"label\":\"Rarely\"},{\"id\":\"sometimes\",\"label\":\"Sometimes\"},{\"id\":\"often\",\"label\":\"Often\"}]}'),
    jsonDecode(
        '{\"key\":\"future_feeling\",\"question\":\"If nothing changed, how would you feel a year from now about your evangelism?\",\"answers\":[{\"id\":\"fine\",\"label\":\"Fine\"},{\"id\":\"concerned\",\"label\":\"A little concerned\"},{\"id\":\"regretful\",\"label\":\"Regretful\"},{\"id\":\"deeply_convicted\",\"label\":\"Deeply convicted\"}]}'),
    jsonDecode(
        '{\"key\":\"barriers\",\"question\":\"What usually stops you from sharing?\",\"answers\":[{\"id\":\"fear_rejection\",\"label\":\"❌  Fear of rejection\"},{\"id\":\"not_knowing_what_to_say\",\"label\":\"🤷  Not knowing what to say\"},{\"id\":\"dont_want_to_offend\",\"label\":\"🏃  Don’t want to offend\"},{\"id\":\"waiting_right_moment\",\"label\":\"⏱️  Waiting for the “right moment”\"},{\"id\":\"dont_think_about_it\",\"label\":\"🧠  I don’t think about it\"},{\"id\":\"feel_unqualified\",\"label\":\"🙁  I feel unqualified\"},{\"id\":\"none\",\"label\":\"🔐  None of the above\"}]}')
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

  List<String> _nudgedFriends = [];
  List<String> get nudgedFriends => _nudgedFriends;
  set nudgedFriends(List<String> value) {
    _nudgedFriends = value;
  }

  void addToNudgedFriends(String value) {
    nudgedFriends.add(value);
  }

  void removeFromNudgedFriends(String value) {
    nudgedFriends.remove(value);
  }

  void removeAtIndexFromNudgedFriends(int index) {
    nudgedFriends.removeAt(index);
  }

  void updateNudgedFriendsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    nudgedFriends[index] = updateFn(_nudgedFriends[index]);
  }

  void insertAtIndexInNudgedFriends(int index, String value) {
    nudgedFriends.insert(index, value);
  }

  /// An int for the number of selected answers for multiple choice question for
  /// onboarding.
  int _selectedMultiAnswers = 0;
  int get selectedMultiAnswers => _selectedMultiAnswers;
  set selectedMultiAnswers(int value) {
    _selectedMultiAnswers = value;
  }

  List<String> _activityReactions = [];
  List<String> get activityReactions => _activityReactions;
  set activityReactions(List<String> value) {
    _activityReactions = value;
    prefs.setStringList('ff_activityReactions', value);
  }

  void addToActivityReactions(String value) {
    activityReactions.add(value);
    prefs.setStringList('ff_activityReactions', _activityReactions);
  }

  void removeFromActivityReactions(String value) {
    activityReactions.remove(value);
    prefs.setStringList('ff_activityReactions', _activityReactions);
  }

  void removeAtIndexFromActivityReactions(int index) {
    activityReactions.removeAt(index);
    prefs.setStringList('ff_activityReactions', _activityReactions);
  }

  void updateActivityReactionsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    activityReactions[index] = updateFn(_activityReactions[index]);
    prefs.setStringList('ff_activityReactions', _activityReactions);
  }

  void insertAtIndexInActivityReactions(int index, String value) {
    activityReactions.insert(index, value);
    prefs.setStringList('ff_activityReactions', _activityReactions);
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

  final _ulpsManager = FutureRequestManager<List<UserLessonProgressRow>>();
  Future<List<UserLessonProgressRow>> ulps({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserLessonProgressRow>> Function() requestFn,
  }) =>
      _ulpsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUlpsCache() => _ulpsManager.clear();
  void clearUlpsCacheKey(String? uniqueKey) =>
      _ulpsManager.clearRequest(uniqueKey);

  final _lessonsManager = FutureRequestManager<List<CourseLessonsRow>>();
  Future<List<CourseLessonsRow>> lessons({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CourseLessonsRow>> Function() requestFn,
  }) =>
      _lessonsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearLessonsCache() => _lessonsManager.clear();
  void clearLessonsCacheKey(String? uniqueKey) =>
      _lessonsManager.clearRequest(uniqueKey);
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
