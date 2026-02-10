import '/backend/ai_agents/ai_agent.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'simulator_model.dart';
export 'simulator_model.dart';

class SimulatorWidget extends StatefulWidget {
  const SimulatorWidget({
    super.key,
    required this.persona,
  });

  final SimulatorPersonasRow? persona;

  static String routeName = 'simulator';
  static String routePath = 'simulator';

  @override
  State<SimulatorWidget> createState() => _SimulatorWidgetState();
}

class _SimulatorWidgetState extends State<SimulatorWidget> {
  late SimulatorModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SimulatorModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'simulator'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.chatID = random_data.randomInteger(0, 10).toString();
      safeSetState(() {});
      _model.timerController.onStartTimer();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
              context.safePop();
            },
            child: Icon(
              Icons.close,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 25.0,
            ),
          ),
          title: Text(
            '${widget.persona?.name} Persona',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Container(
                          width: 210.0,
                          height: 210.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 200),
                            fadeOutDuration: Duration(milliseconds: 200),
                            imageUrl: valueOrDefault<String>(
                              widget.persona?.thumbnailUrl,
                              'https://picsum.photos/seed/422/600',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 100.0,
                        child: custom_widgets.DeepgramSTT(
                          width: double.infinity,
                          height: 100.0,
                          deepgramApiKey: FFAppState().deepgramApiKey,
                          apiKey: FFAppState().openaiApiKey,
                          fontSize: 16.0,
                          fontColor: FlutterFlowTheme.of(context).primaryText,
                          chatCompletion: (words) async {
                            await callAiAgent(
                              context: context,
                              prompt:
                                  'persona=${widget.persona?.personaInstructions}, user_words=${words}',
                              threadId: valueOrDefault<String>(
                                _model.chatID,
                                'testing',
                              ),
                              agentCloudFunctionName: 'personaAI',
                              provider: 'OPENAI',
                              agentJson: null,
                              responseType: 'PLAINTEXT',
                            ).then((generatedText) {
                              safeSetState(
                                  () => _model.agentResponse = generatedText);
                            });

                            // Add user words to history
                            FFAppState()
                                .addToSimulatorHistory('user_words:  ${words}');
                            safeSetState(() {});
                            // Add AI response to history
                            FFAppState().addToSimulatorHistory(
                                'persona_words:  ${_model.agentResponse}');
                            safeSetState(() {});
                            FFAppState().agentResponse = _model.agentResponse!;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 40.0, 16.0, 0.0),
                          child: Text(
                            'You can always ask for a different question ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFC2C2C2),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                  lineHeight: 1.6,
                                ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                  child: wrapWithModel(
                    model: _model.largeBtnModel,
                    updateCallback: () => safeSetState(() {}),
                    updateOnChange: true,
                    child: LargeBtnWidget(
                      text: 'Get Feedback',
                      color: FlutterFlowTheme.of(context).secondary,
                      textColor: FlutterFlowTheme.of(context).info,
                      action: () async {
                        if (isiOS) {
                          _model.responseAuth =
                              await actions.cupertinoConfirmationDialog(
                            context,
                            'End Conversation?',
                            'To get feedback, this conversation will end.',
                            'Cancel',
                            'Proceed',
                            FlutterFlowTheme.of(context).success,
                            FlutterFlowTheme.of(context).secondary,
                          );
                          if (_model.responseAuth!) {
                            context.goNamed(
                              SimulatorAnalysisWidget.routeName,
                              queryParameters: {
                                'persona': serializeParam(
                                  widget.persona,
                                  ParamType.SupabaseRow,
                                ),
                                'duration': serializeParam(
                                  _model.timerValue,
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          }
                        } else {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('End Conversation?'),
                                    content: Text(
                                        'To get feedback, this conversation will end.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Proceed'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            context.goNamed(
                              SimulatorAnalysisWidget.routeName,
                              queryParameters: {
                                'persona': serializeParam(
                                  widget.persona,
                                  ParamType.SupabaseRow,
                                ),
                                'duration': serializeParam(
                                  _model.timerValue,
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          }
                        }

                        safeSetState(() {});
                      },
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: FlutterFlowTimer(
                    initialTime: _model.timerInitialTimeMs,
                    getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                        value,
                        milliSecond: false),
                    controller: _model.timerController,
                    updateStateInterval: Duration(milliseconds: 10000),
                    onChanged: (value, displayTime, shouldUpdate) {
                      _model.timerMilliseconds = value;
                      _model.timerValue = displayTime;
                      if (shouldUpdate) safeSetState(() {});
                    },
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
