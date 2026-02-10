import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'chat_history_widget.dart' show ChatHistoryWidget;
import 'package:flutter/material.dart';

class ChatHistoryModel extends FlutterFlowModel<ChatHistoryWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();
  }
}
