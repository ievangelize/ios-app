import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/streak/streak_widget.dart';
import '/components/tap_to_complete_btn/tap_to_complete_btn_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'accepted_mission_details_model.dart';
export 'accepted_mission_details_model.dart';

class AcceptedMissionDetailsWidget extends StatefulWidget {
  const AcceptedMissionDetailsWidget({
    super.key,
    required this.mission,
  });

  final UserAssignedMissionsRow? mission;

  @override
  State<AcceptedMissionDetailsWidget> createState() =>
      _AcceptedMissionDetailsWidgetState();
}

class _AcceptedMissionDetailsWidgetState
    extends State<AcceptedMissionDetailsWidget> {
  late AcceptedMissionDetailsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AcceptedMissionDetailsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 55.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 3.0,
              indent: 150.0,
              endIndent: 150.0,
              color: FlutterFlowTheme.of(context).accent1,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      valueOrDefault<String>(
                        widget.mission?.title,
                        'Engagement 101',
                      ),
                      textAlign: TextAlign.center,
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget.mission?.description,
                      'Prepare and practice',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ].divide(SizedBox(height: 8.0)),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 44.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  await UserAssignedMissionsTable().update(
                    data: {
                      'status': 'archived',
                    },
                    matchingRows: (rows) => rows
                        .eqOrNull(
                          'id',
                          widget.mission?.id,
                        )
                        .eqOrNull(
                          'user_id',
                          widget.mission?.userId,
                        ),
                  );
                  FFAppState().clearUserAssignedMissionsCache();
                  Navigator.pop(context);
                },
                text: 'Archive Mission',
                icon: FaIcon(
                  FontAwesomeIcons.archive,
                  size: 15.0,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 54.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFF13A28),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            Builder(
              builder: (context) => Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: wrapWithModel(
                  model: _model.tapToCompleteBtnModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TapToCompleteBtnWidget(
                    action: () async {
                      await UserAssignedMissionsTable().update(
                        data: {
                          'status': 'completed',
                          'complete_at':
                              supaSerialize<DateTime>(getCurrentTimestamp),
                        },
                        matchingRows: (rows) => rows
                            .eqOrNull(
                              'id',
                              widget.mission?.id,
                            )
                            .eqOrNull(
                              'user_id',
                              widget.mission?.userId,
                            ),
                      );
                      unawaited(
                        () async {
                          await XpEventsTable().insert({
                            'user_id': currentUserUid,
                            'delta': widget.mission?.xpReward,
                            'reason': 'mission complete',
                            'idempotency_key': widget.mission?.id,
                          });
                        }(),
                      );
                      FFAppState().clearUserAssignedMissionsCache();
                      _model.xpEvent = await XpEventsTable().queryRows(
                        queryFn: (q) => q.eqOrNull(
                          'user_id',
                          currentUserUid,
                        ),
                      );
                      Navigator.pop(context);
                      _model.streak = await actions.calculateStreak(
                        _model.xpEvent!.map((e) => e.createdAt).toList(),
                        FFAppState().currentStreak,
                      );
                      if (getJsonField(
                        _model.streak!.lastOrNull,
                        r'''$.is_streak''',
                      )) {
                        FFAppState().currentStreak = getJsonField(
                          _model.streak!.elementAtOrNull(1),
                          r'''$.streak''',
                        );
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
                          barrierDismissible: false,
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: AlignmentDirectional(0.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: StreakWidget(
                                  streakAmount: getJsonField(
                                    _model.streak?.elementAtOrNull(1),
                                    r'''$.streak''',
                                  ).toString(),
                                  streakDays: getJsonField(
                                    _model.streak?.firstOrNull,
                                    r'''$.active_days''',
                                    true,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }

                      context.goNamed(
                        MissionCompleteWidget.routeName,
                        queryParameters: {
                          'missionXp': serializeParam(
                            widget.mission?.xpReward,
                            ParamType.int,
                          ),
                          'missionTitle': serializeParam(
                            widget.mission?.title,
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
          ],
        ),
      ),
    );
  }
}
