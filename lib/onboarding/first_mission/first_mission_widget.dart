import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/components/streak/streak_widget.dart';
import '/components/tap_to_complete_btn/tap_to_complete_btn_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'first_mission_model.dart';
export 'first_mission_model.dart';

class FirstMissionWidget extends StatefulWidget {
  const FirstMissionWidget({super.key});

  static String routeName = 'firstMission';
  static String routePath = 'firstMission';

  @override
  State<FirstMissionWidget> createState() => _FirstMissionWidgetState();
}

class _FirstMissionWidgetState extends State<FirstMissionWidget>
    with TickerProviderStateMixin {
  late FirstMissionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FirstMissionModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'firstMission'});
    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.bounceOut,
            delay: 400.0.ms,
            duration: 800.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
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

    return FutureBuilder<List<MissionsCatalogRow>>(
      future: MissionsCatalogTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'title',
          'Invite a Laborer',
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: SpinKitFadingCircle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20.0,
                ),
              ),
            ),
          );
        }
        List<MissionsCatalogRow> firstMissionMissionsCatalogRowList =
            snapshot.data!;

        final firstMissionMissionsCatalogRow =
            firstMissionMissionsCatalogRowList.isNotEmpty
                ? firstMissionMissionsCatalogRowList.first
                : null;

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
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 80.0),
                      child: Container(
                        width: 300.0,
                        height: 390.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF6495ED), Color(0xFF7C9EC3)],
                            stops: [0.0, 1.0],
                            begin: AlignmentDirectional(0.0, -1.0),
                            end: AlignmentDirectional(0, 1.0),
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x606495ED),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      'YOUR FIRST MISSION',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image.asset(
                                      'assets/images/help.png',
                                      width: 55.0,
                                      height: 55.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        firstMissionMissionsCatalogRow?.title,
                                        'Invite a Laborer',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 12.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        firstMissionMissionsCatalogRow
                                            ?.description,
                                        'Share iEvangelize with a friend  and practice becoming bold  witnesses together',
                                      ),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
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
                                  Text(
                                    'Will you accept?',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Builder(
                          builder: (context) => Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: wrapWithModel(
                              model: _model.tapToCompleteBtnModel,
                              updateCallback: () => safeSetState(() {}),
                              child: TapToCompleteBtnWidget(
                                action: () async {
                                  await Share.share(
                                    _model.shareMessage,
                                    sharePositionOrigin:
                                        getWidgetBoundingBox(context),
                                  );
                                  _model.newMission =
                                      await UserAssignedMissionsTable().insert({
                                    'title':
                                        firstMissionMissionsCatalogRow?.title,
                                    'description':
                                        firstMissionMissionsCatalogRow
                                            ?.description,
                                    'user_id': currentUserUid,
                                    'mission_catalog_id':
                                        firstMissionMissionsCatalogRow?.id,
                                    'status': 'completed',
                                    'xp_reward': firstMissionMissionsCatalogRow
                                        ?.xpReward,
                                    'complete_at': supaSerialize<DateTime>(
                                        getCurrentTimestamp),
                                  });
                                  _model.xpEvent =
                                      await XpEventsTable().insert({
                                    'user_id': currentUserUid,
                                    'delta': firstMissionMissionsCatalogRow
                                        ?.xpReward,
                                    'reason': 'mission complete',
                                    'idempotency_key': _model.newMission?.id,
                                  });
                                  FFAppState().currentStreak = 1;
                                  FFAppState().addToActiveDays(getJsonField(
                                    <String, String>{
                                      'day': dateTimeFormat(
                                        "E",
                                        _model.xpEvent!.createdAt,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                    },
                                    r'''$.day''',
                                  ));
                                  await UsersTable().update(
                                    data: {
                                      'streak': FFAppState().currentStreak,
                                    },
                                    matchingRows: (rows) => rows.eqOrNull(
                                      'id',
                                      currentUserUid,
                                    ),
                                  );
                                  await showDialog(
                                    barrierColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: StreakWidget(
                                              streakAmount: '1',
                                              streakDays:
                                                  FFAppState().activeDays,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  context.goNamed(
                                    MissionCompleteWidget.routeName,
                                    queryParameters: {
                                      'missionXp': serializeParam(
                                        firstMissionMissionsCatalogRow
                                            ?.xpReward,
                                        ParamType.int,
                                      ),
                                      'missionTitle': serializeParam(
                                        firstMissionMissionsCatalogRow?.title,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      '__transition_info__': TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );

                                  safeSetState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 12.0),
                          child: wrapWithModel(
                            model: _model.largeBtnModel,
                            updateCallback: () => safeSetState(() {}),
                            child: LargeBtnWidget(
                              text: 'No, I’ll pass',
                              color: Colors.transparent,
                              textColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              action: () async {
                                await UserAssignedMissionsTable().insert({
                                  'title':
                                      firstMissionMissionsCatalogRow?.title,
                                  'description': firstMissionMissionsCatalogRow
                                      ?.description,
                                  'user_id': currentUserUid,
                                  'mission_catalog_id':
                                      firstMissionMissionsCatalogRow?.id,
                                  'status': 'accepted',
                                  'xp_reward':
                                      firstMissionMissionsCatalogRow?.xpReward,
                                });

                                context.pushNamed(HomeWidget.routeName);
                              },
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 12.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
