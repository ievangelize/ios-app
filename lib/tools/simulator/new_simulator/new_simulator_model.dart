import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'new_simulator_widget.dart' show NewSimulatorWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class NewSimulatorModel extends FlutterFlowModel<NewSimulatorWidget> {
  ///  Local state fields for this page.

  String? simulatorResponse = ' ';

  String status = 'init';

  bool showStatus = true;

  String? responseID;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Persona AI First)] action in newSimulator widget.
  ApiCallResponse? apiResultj08;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 0;
  int timerMilliseconds = 0;
  String timerValue = StopWatchTimer.getDisplayTime(0, milliSecond: false);
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countUp));

  // Stores action output result for [Custom Action - stopRecordingAction] action in stopRecord widget.
  String? transcript;
  // Stores action output result for [Backend Call - API (Persona AI Next)] action in stopRecord widget.
  ApiCallResponse? apiResultg3a;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Container widget.
  bool? responseAuth;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    timerController.dispose();
  }
}
