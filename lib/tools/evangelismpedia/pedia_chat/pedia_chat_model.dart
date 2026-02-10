import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/chat_item_stream/chat_item_stream_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pedia_chat_widget.dart' show PediaChatWidget;
import 'package:flutter/material.dart';

class PediaChatModel extends FlutterFlowModel<PediaChatWidget> {
  ///  Local state fields for this page.

  bool newMessage = true;

  bool stillStreaming = false;

  bool firstMessage = true;

  String conversationTitle = 'Untitled';

  String? userMessage;

  bool chatVisible = false;

  String? previousRespnseId;

  bool isThinking = false;

  String? conversationId;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Query Rows] action in pediaChat widget.
  List<ConversationMessagesRow>? oldMessages;
  // State field(s) for ColumnChat widget.
  ScrollController? columnChatScrollController;
  // State field(s) for ListViewChat widget.
  ScrollController? listViewChatScrollController;
  // Models for chatItemStream dynamic component.
  late FlutterFlowDynamicModels<ChatItemStreamModel> chatItemStreamModels;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // State field(s) for UserMessage widget.
  FocusNode? userMessageFocusNode;
  TextEditingController? userMessageTextController;
  String? Function(BuildContext, String?)? userMessageTextControllerValidator;
  String? _userMessageTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Any me anything is required';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Insert Row] action in IconButton widget.
  ConversationsRow? newConversation;
  // Stores action output result for [Backend Call - API (Evangelismpedia First)] action in IconButton widget.
  ApiCallResponse? apiResulth8u;
  // Stores action output result for [Backend Call - API (Evangelismpedia Next Message)] action in IconButton widget.
  ApiCallResponse? apiResulthNext;
  // Stores action output result for [AI Agent - Send Message to Coach Title Creator] action in IconButton widget.
  String? newTitle;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<XpEventsRow>? xpEvents;
  // Stores action output result for [Custom Action - calculateStreak] action in Icon widget.
  List<dynamic>? streak;

  @override
  void initState(BuildContext context) {
    columnChatScrollController = ScrollController();
    listViewChatScrollController = ScrollController();
    chatItemStreamModels =
        FlutterFlowDynamicModels(() => ChatItemStreamModel());
    rowController = ScrollController();
    userMessageTextControllerValidator = _userMessageTextControllerValidator;
  }

  @override
  void dispose() {
    columnChatScrollController?.dispose();
    listViewChatScrollController?.dispose();
    chatItemStreamModels.dispose();
    rowController?.dispose();
    userMessageFocusNode?.dispose();
    userMessageTextController?.dispose();
  }
}
