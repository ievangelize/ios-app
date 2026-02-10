import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'onboarding_analyzing_widget.dart' show OnboardingAnalyzingWidget;
import 'package:flutter/material.dart';

class OnboardingAnalyzingModel
    extends FlutterFlowModel<OnboardingAnalyzingWidget> {
  ///  Local state fields for this page.

  List<String> phrases = [
    'Analyzing your evangelism experience...',
    'Reviewing your conversation patterns...',
    'Calibrating your growth journey...',
    'Preparing your first missions and lessons...',
    'Building your personalized experience...'
  ];
  void addToPhrases(String item) => phrases.add(item);
  void removeFromPhrases(String item) => phrases.remove(item);
  void removeAtIndexFromPhrases(int index) => phrases.removeAt(index);
  void insertAtIndexInPhrases(int index, String item) =>
      phrases.insert(index, item);
  void updatePhrasesAtIndex(int index, Function(String) updateFn) =>
      phrases[index] = updateFn(phrases[index]);

  String phrase = 'Analyzing your evangelism experience...';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Allocate Current Course)] action in onboardingAnalyzing widget.
  ApiCallResponse? apiResultptr;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
