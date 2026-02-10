import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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

class _OnboardingAnalyzingWidgetState extends State<OnboardingAnalyzingWidget> {
  late OnboardingAnalyzingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingAnalyzingModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'onboardingAnalyzing'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((getJsonField(
                FFAppState().onboardingSnapshot.elementAtOrNull(1),
                r'''$.experience''',
              ) ==
              getJsonField(
                <String, String>{
                  'experience': 'share_regularly',
                },
                r'''$.experience''',
              )) &&
          (getJsonField(
                FFAppState().onboardingSnapshot.elementAtOrNull(6),
                r'''$.confidence_level''',
              ) ==
              getJsonField(
                <String, String>{
                  'confidence_level': 'very_confident',
                },
                r'''$.confidence_level''',
              )) &&
          (getJsonField(
                FFAppState().onboardingSnapshot.elementAtOrNull(4),
                r'''$.last_shared''',
              ) ==
              getJsonField(
                <String, String>{
                  'last_shared': 'within_30d',
                },
                r'''$.last_shared''',
              )) &&
          (getJsonField(
                FFAppState().onboardingSnapshot.elementAtOrNull(8),
                r'''$.urgency_view''',
              ) ==
              getJsonField(
                <String, String>{
                  'urgency_view': 'urgent',
                },
                r'''$.urgency_view''',
              ))) {
        await UsersTable().update(
          data: {
            'onboarding_snapshot': <String?, List<dynamic>?>{
              '': FFAppState().onboardingSnapshot,
            },
            'full_name': getJsonField(
              FFAppState().onboardingSnapshot.elementAtOrNull(2),
              r'''$.name''',
            ).toString(),
            'onboarding_level': 'advanced',
            'fcm_token': FFAppState().fcmToken,
            'cumulative_xp': 5000,
            'onboarding_complete': true,
            'streak': 1,
          },
          matchingRows: (rows) => rows.eqOrNull(
            'id',
            currentUserUid,
          ),
        );
      } else if (((getJsonField(
                    FFAppState().onboardingSnapshot.elementAtOrNull(1),
                    r'''$.experience''',
                  ) ==
                  getJsonField(
                    <String, String>{
                      'experience': 'never_shared',
                    },
                    r'''$.experience''',
                  )) ||
              (getJsonField(
                    FFAppState().onboardingSnapshot.elementAtOrNull(1),
                    r'''$.experience''',
                  ) ==
                  getJsonField(
                    <String, String>{
                      'experience': 'tried_once_twice',
                    },
                    r'''$.experience''',
                  ))) &&
          ((getJsonField(
                    FFAppState().onboardingSnapshot.elementAtOrNull(6),
                    r'''$.confidence_level''',
                  ) ==
                  getJsonField(
                    <String, String>{
                      'confidence_level': 'not_confident',
                    },
                    r'''$.confidence_level''',
                  )) ||
              (getJsonField(
                    FFAppState().onboardingSnapshot.elementAtOrNull(6),
                    r'''$.confidence_level''',
                  ) ==
                  getJsonField(
                    <String, String>{
                      'confidence_level': 'little_confident',
                    },
                    r'''$.confidence_level''',
                  ))) &&
          ((getJsonField(
                    FFAppState().onboardingSnapshot.elementAtOrNull(4),
                    r'''$.last_shared''',
                  ) ==
                  getJsonField(
                    <String, String>{
                      'last_shared': 'never_shared',
                    },
                    r'''$.last_shared''',
                  )) ||
              (getJsonField(
                    FFAppState().onboardingSnapshot.elementAtOrNull(4),
                    r'''$.last_shared''',
                  ) ==
                  getJsonField(
                    <String, String>{
                      'last_shared': 'over_1_month',
                    },
                    r'''$.last_shared''',
                  )))) {
        await UsersTable().update(
          data: {
            'onboarding_snapshot': <String?, List<dynamic>?>{
              '': FFAppState().onboardingSnapshot,
            },
            'full_name': getJsonField(
              FFAppState().onboardingSnapshot.elementAtOrNull(2),
              r'''$.name''',
            ).toString(),
            'onboarding_level': 'beginner',
            'fcm_token': FFAppState().fcmToken,
            'cumulative_xp': 0,
            'onboarding_complete': true,
            'streak': 1,
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
              FFAppState().onboardingSnapshot.elementAtOrNull(2),
              r'''$.name''',
            ).toString(),
            'onboarding_level': 'intermediate',
            'fcm_token': FFAppState().fcmToken,
            'cumulative_xp': 1000,
            'onboarding_complete': true,
            'streak': 1,
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
        await Future.delayed(
          Duration(
            milliseconds: 5000,
          ),
        );

        context.goNamed(
          OnboardingQuoteWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Just a moment',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 26.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                  _model.phrase,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.2,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
