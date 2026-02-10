import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'conversation_analysis_widget.dart' show ConversationAnalysisWidget;
import 'package:flutter/material.dart';

class ConversationAnalysisModel
    extends FlutterFlowModel<ConversationAnalysisWidget> {
  ///  Local state fields for this page.

  String simulationState = 'Listening';

  String? chatID;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [AI Agent - Send Message to Conversation Starter] action in conversationAnalysis widget.
  Map<String, dynamic>? agentResponse;
  // Stores action output result for [Backend Call - Insert Row] action in conversationAnalysis widget.
  SituationRow? newSituation;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
