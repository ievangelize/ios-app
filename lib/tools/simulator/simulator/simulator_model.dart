import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'simulator_widget.dart' show SimulatorWidget;
import 'package:flutter/material.dart';

class SimulatorModel extends FlutterFlowModel<SimulatorWidget> {
  ///  Local state fields for this page.

  String simulationState = 'Listening';

  String? chatID;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [AI Agent - Send Message to Persona AI] action in DeepgramSTT widget.
  String? agentResponse;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in largeBtn widget.
  bool? responseAuth;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 0;
  int timerMilliseconds = 0;
  String timerValue = StopWatchTimer.getDisplayTime(0, milliSecond: false);
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countUp));

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel.dispose();
    timerController.dispose();
  }
}
