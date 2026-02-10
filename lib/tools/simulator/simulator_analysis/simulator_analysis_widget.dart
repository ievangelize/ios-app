import '/auth/supabase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'simulator_analysis_model.dart';
export 'simulator_analysis_model.dart';

class SimulatorAnalysisWidget extends StatefulWidget {
  const SimulatorAnalysisWidget({
    super.key,
    required this.persona,
    required this.duration,
  });

  final SimulatorPersonasRow? persona;
  final String? duration;

  static String routeName = 'simulatorAnalysis';
  static String routePath = 'analysis';

  @override
  State<SimulatorAnalysisWidget> createState() =>
      _SimulatorAnalysisWidgetState();
}

class _SimulatorAnalysisWidgetState extends State<SimulatorAnalysisWidget> {
  late SimulatorAnalysisModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SimulatorAnalysisModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'simulatorAnalysis'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await callAiAgent(
        context: context,
        prompt:
            '{\"persona\":\" ${widget.persona?.personaInstructions}\"},${functions.convertListtoString(FFAppState().simulatorHistory.toList())}',
        threadId: random_data.randomString(
          16,
          16,
          true,
          true,
          true,
        ),
        agentCloudFunctionName: 'simulatorAnalyzer',
        provider: 'OPENAI',
        agentJson: null,
        responseType: 'JSON',
      ).then((generatedText) {
        safeSetState(() => _model.agentReponse = generatedText);
      });

      await SimulatorFeedbackTable().insert({
        'user_id': currentUserUid,
        'persona_id': widget.persona?.id,
        'feedback_text': getJsonField(
          _model.agentReponse,
          r'''$.response''',
        ).toString(),
        'duration': widget.duration,
        'feedback_title': getJsonField(
          _model.agentReponse,
          r'''$.feedback_title''',
        ).toString(),
      });
      FFAppState().simulatorHistory = [];
      FFAppState().agentResponse = '';
      safeSetState(() {});
      FFAppState().clearSimulatorFeedbackCache();

      context.goNamed(
        FeedbackWidget.routeName,
        queryParameters: {
          'chatFeedback': serializeParam(
            getJsonField(
              _model.agentReponse,
              r'''$.response''',
            ).toString(),
            ParamType.String,
          ),
        }.withoutNulls,
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              FFAppState().simulatorHistory = [];
              FFAppState().agentResponse = '';
              safeSetState(() {});

              context.goNamed(PickPersonaWidget.routeName);
            },
            child: Icon(
              Icons.close,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 25.0,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Analyzing the \nconversation',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 28.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Lottie.asset(
                      'assets/jsons/Sphere_Splitter.json',
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 400.0,
                      fit: BoxFit.contain,
                      animate: true,
                    ),
                    Text(
                      'You\'ll get your feedback in \njust a moment',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
