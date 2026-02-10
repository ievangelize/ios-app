import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'simulator_history_widget.dart' show SimulatorHistoryWidget;
import 'package:flutter/material.dart';

class SimulatorHistoryModel extends FlutterFlowModel<SimulatorHistoryWidget> {
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
