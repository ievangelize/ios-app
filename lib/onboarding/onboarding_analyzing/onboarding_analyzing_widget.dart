import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'onboarding_analyzing_model.dart';
export 'onboarding_analyzing_model.dart';

class OnboardingAnalyzingWidget extends StatefulWidget {
  const OnboardingAnalyzingWidget({super.key});

  static String routeName = 'onboardingAnalyzing';
  static String routePath = 'onboardingAnalyzing';

  @override
  State<OnboardingAnalyzingWidget> createState() =>
      _OnboardingAnalyzingWidgetState();
}

class _OnboardingAnalyzingWidgetState extends State<OnboardingAnalyzingWidget>
    with TickerProviderStateMixin {
  late OnboardingAnalyzingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingAnalyzingModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'onboardingAnalyzing'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          while (_model.percentComplete < 100) {
            if (_model.percentComplete == 93 ? true : false) {
              await Future.delayed(
                Duration(
                  milliseconds: 400,
                ),
              );
            } else {
              await Future.delayed(
                Duration(
                  milliseconds: 50,
                ),
              );
            }

            if (_model.percentComplete == 5 ? true : false) {
              if (animationsMap['containerOnActionTriggerAnimation1'] != null) {
                animationsMap['containerOnActionTriggerAnimation1']!
                    .controller
                    .forward(from: 0.0);
              }
              HapticFeedback.mediumImpact();
            } else if (_model.percentComplete == 30 ? true : false) {
              if (animationsMap['containerOnActionTriggerAnimation2'] != null) {
                animationsMap['containerOnActionTriggerAnimation2']!
                    .controller
                    .forward(from: 0.0);
              }
              HapticFeedback.mediumImpact();
            } else if (_model.percentComplete == 60 ? true : false) {
              if (animationsMap['containerOnActionTriggerAnimation3'] != null) {
                animationsMap['containerOnActionTriggerAnimation3']!
                    .controller
                    .forward(from: 0.0);
              }
              HapticFeedback.mediumImpact();
            } else if (_model.percentComplete == 90 ? true : false) {
              if (animationsMap['containerOnActionTriggerAnimation4'] != null) {
                animationsMap['containerOnActionTriggerAnimation4']!
                    .controller
                    .forward(from: 0.0);
              }
              HapticFeedback.mediumImpact();
            }

            _model.percentComplete = _model.percentComplete + 1;
            safeSetState(() {});
          }
          _model.countComplete = true;
          safeSetState(() {});
        }),
        Future(() async {
          _model.deviceTimeZone = await actions.getTimeZone();
          if (getJsonField(
                FFAppState().onboardingSnapshot.elementAtOrNull(3),
                r'''$.experience''',
              ) ==
              getJsonField(
                <String, String>{
                  'experience': 'share_regularly',
                },
                r'''$.experience''',
              )) {
            await UsersTable().update(
              data: {
                'onboarding_snapshot': <String?, List<dynamic>?>{
                  '': FFAppState().onboardingSnapshot,
                },
                'full_name': getJsonField(
                  FFAppState().onboardingSnapshot.elementAtOrNull(1),
                  r'''$.name''',
                ).toString(),
                'onboarding_level': 'advanced',
                'fcm_token': FFAppState().fcmToken,
                'cumulative_xp': 5000,
                'onboarding_complete': true,
                'streak': 1,
                'timezone': _model.deviceTimeZone,
              },
              matchingRows: (rows) => rows.eqOrNull(
                'id',
                currentUserUid,
              ),
            );
          } else if ((getJsonField(
                    FFAppState().onboardingSnapshot.elementAtOrNull(3),
                    r'''$.experience''',
                  ) ==
                  getJsonField(
                    <String, String>{
                      'experience': 'tried_once_twice',
                    },
                    r'''$.experience''',
                  )) ||
              (getJsonField(
                    FFAppState().onboardingSnapshot.elementAtOrNull(3),
                    r'''$.experience''',
                  ) ==
                  getJsonField(
                    <String, String>{
                      'experience': 'never_shared',
                    },
                    r'''$.experience''',
                  ))) {
            await UsersTable().update(
              data: {
                'onboarding_snapshot': <String?, List<dynamic>?>{
                  '': FFAppState().onboardingSnapshot,
                },
                'full_name': getJsonField(
                  FFAppState().onboardingSnapshot.elementAtOrNull(1),
                  r'''$.name''',
                ).toString(),
                'onboarding_level': 'beginner',
                'fcm_token': FFAppState().fcmToken,
                'cumulative_xp': 0,
                'onboarding_complete': true,
                'streak': 1,
                'timezone': _model.deviceTimeZone,
              },
              matchingRows: (rows) => rows.eqOrNull(
                'id',
                currentUserUid,
              ),
            );
          } else {
            await UsersTable().update(
              data: {
                'onboarding_snapshot': <String?, List<dynamic>?>{
                  '': FFAppState().onboardingSnapshot,
                },
                'full_name': getJsonField(
                  FFAppState().onboardingSnapshot.elementAtOrNull(1),
                  r'''$.name''',
                ).toString(),
                'onboarding_level': 'intermediate',
                'fcm_token': FFAppState().fcmToken,
                'cumulative_xp': 1000,
                'onboarding_complete': true,
                'streak': 1,
                'timezone': _model.deviceTimeZone,
              },
              matchingRows: (rows) => rows.eqOrNull(
                'id',
                currentUserUid,
              ),
            );
          }

          _model.apiResultptr = await AllocateCurrentCourseCall.call(
            userId: currentUserUid,
            token: FFAppState().SupabaseKey,
          );

          if ((_model.apiResultptr?.succeeded ?? true)) {
            FFAppState().onboardingComplete = true;
          } else {
            return;
          }

          _model.databaseDone = true;
          safeSetState(() {});
        }),
      ]);
      safeSetState(() {});
    });

    animationsMap.addAll({
      'containerOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnActionTriggerAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnActionTriggerAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          '${_model.percentComplete.toString()}%',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Colors.black,
                                    fontSize: 60.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    lineHeight: 1.2,
                                  ),
                        ),
                      ),
                      Text(
                        'We\'re setting \nup everything for you',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: Colors.black,
                              fontSize: 26.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                              lineHeight: 1.2,
                            ),
                      ),
                      LinearPercentIndicator(
                        percent: functions.coursePercantage(
                            _model.percentComplete, 100),
                        lineHeight: 10.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: FlutterFlowTheme.of(context).secondary,
                        backgroundColor: Color(0xFFDFDFDF),
                        barRadius: Radius.circular(12.0),
                        padding: EdgeInsets.zero,
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 24.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x19000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Color(0xFFDFDFDF),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 12.0, 12.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Analyzing evangelism experience',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF5C9342),
                                        size: 22.0,
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                              ).animateOnActionTrigger(
                                animationsMap[
                                    'containerOnActionTriggerAnimation1']!,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x19000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Color(0xFFDFDFDF),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 12.0, 12.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Reviewing conversation patterns',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF5C9342),
                                        size: 22.0,
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                              ).animateOnActionTrigger(
                                animationsMap[
                                    'containerOnActionTriggerAnimation2']!,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x19000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Color(0xFFDFDFDF),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 12.0, 12.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Calibrating your growth journey',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF5C9342),
                                        size: 22.0,
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                              ).animateOnActionTrigger(
                                animationsMap[
                                    'containerOnActionTriggerAnimation3']!,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x19000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Color(0xFFDFDFDF),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 12.0, 12.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Building personalized experience',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF5C9342),
                                        size: 22.0,
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                              ).animateOnActionTrigger(
                                animationsMap[
                                    'containerOnActionTriggerAnimation4']!,
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
              ),
              if ((_model.databaseDone == true) &&
                  (_model.countComplete == true))
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                    child: wrapWithModel(
                      model: _model.largeBtnModel,
                      updateCallback: () => safeSetState(() {}),
                      child: LargeBtnWidget(
                        text: 'Let\'s get started!',
                        color: Color(0xFF6A55EA),
                        textColor: FlutterFlowTheme.of(context).info,
                        action: () async {
                          context.goNamed(
                            IcebreakerFeatureWidget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                              ),
                            },
                          );
                        },
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
