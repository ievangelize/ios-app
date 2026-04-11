import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'mic_btn_simulator_model.dart';
export 'mic_btn_simulator_model.dart';

class MicBtnSimulatorWidget extends StatefulWidget {
  const MicBtnSimulatorWidget({super.key});

  @override
  State<MicBtnSimulatorWidget> createState() => _MicBtnSimulatorWidgetState();
}

class _MicBtnSimulatorWidgetState extends State<MicBtnSimulatorWidget> {
  late MicBtnSimulatorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MicBtnSimulatorModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: 82.0,
        height: 82.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          shape: BoxShape.circle,
          border: Border.all(
            color: FlutterFlowTheme.of(context).secondary,
            width: 1.0,
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: FaIcon(
            FontAwesomeIcons.microphone,
            color: FlutterFlowTheme.of(context).info,
            size: 32.0,
          ),
        ),
      ),
    );
  }
}
