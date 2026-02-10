import '/auth/supabase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'conversation_analysis_model.dart';
export 'conversation_analysis_model.dart';

class ConversationAnalysisWidget extends StatefulWidget {
  const ConversationAnalysisWidget({
    super.key,
    required this.situation,
  });

  final String? situation;

  static String routeName = 'conversationAnalysis';
  static String routePath = 'conversation-analysis';

  @override
  State<ConversationAnalysisWidget> createState() =>
      _ConversationAnalysisWidgetState();
}

class _ConversationAnalysisWidgetState
    extends State<ConversationAnalysisWidget> {
  late ConversationAnalysisModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConversationAnalysisModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'conversationAnalysis'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await callAiAgent(
        context: context,
        prompt: valueOrDefault<String>(
          widget.situation,
          'situation',
        ),
        threadId: random_data.randomInteger(0, 10).toString(),
        agentCloudFunctionName: 'conversationStarter',
        provider: 'OPENAI',
        agentJson: null,
        responseType: 'JSON',
      ).then((generatedText) {
        safeSetState(() => _model.agentResponse = generatedText);
      });

      if (getJsonField(
        _model.agentResponse,
        r'''$.success''',
      )
          ? true
          : false) {
        _model.newSituation = await SituationTable().insert({
          'situation_info': widget.situation,
          'created_by': currentUserUid,
          'gpt_output_json': _model.agentResponse,
        });
        await XpEventsTable().insert({
          'user_id': currentUserUid,
          'delta': 0,
          'reason': 'ai conversation stater',
          'idempotency_key': _model.newSituation?.id,
          'qualified_for_streak': true,
        });
        FFAppState().clearConversationHistoryCache();

        context.goNamed(
          ConversationStartersWidget.routeName,
          queryParameters: {
            'gptAnswer': serializeParam(
              _model.agentResponse,
              ParamType.JSON,
            ),
          }.withoutNulls,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please try another prompt!',
              style: GoogleFonts.inter(
                color: FlutterFlowTheme.of(context).primaryText,
                fontWeight: FontWeight.normal,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );
        context.safePop();
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              context.goNamed(SituationWidget.routeName);
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
                      'Just a moment',
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
                      'Creating tailored conversation \nstarters and tips',
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
