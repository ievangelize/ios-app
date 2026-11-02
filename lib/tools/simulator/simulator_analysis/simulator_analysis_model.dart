import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'simulator_analysis_widget.dart' show SimulatorAnalysisWidget;
import 'package:flutter/material.dart';

class SimulatorAnalysisModel extends FlutterFlowModel<SimulatorAnalysisWidget> {
  ///  Local state fields for this page.

  String simulationState = 'Listening';

  String? chatID;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Simulator Analyzer)] action in simulatorAnalysis widget.
  ApiCallResponse? apiResultj08;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
