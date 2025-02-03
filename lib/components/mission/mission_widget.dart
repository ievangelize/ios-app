import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/mission_complete/mission_complete_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'mission_model.dart';
export 'mission_model.dart';

class MissionWidget extends StatefulWidget {
  const MissionWidget({
    super.key,
    required this.missionTitle,
    required this.peopleCompleted,
    required this.mission,
    required this.userMissions,
  });

  final String? missionTitle;
  final String? peopleCompleted;
  final MissionsRow? mission;
  final List<UserMissionsRow>? userMissions;

  @override
  State<MissionWidget> createState() => _MissionWidgetState();
}

class _MissionWidgetState extends State<MissionWidget>
    with TickerProviderStateMixin {
  late MissionModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MissionModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.userMissions!
              .where((e) => e.missionId == widget.mission?.id)
              .toList()
              .isNotEmpty
          ? true
          : false) {
        _model.completed = true;
        safeSetState(() {});
      } else {
        _model.completed = false;
        safeSetState(() {});
      }
    });

    animationsMap.addAll({
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 2.0,
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
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          HapticFeedback.heavyImpact();
          if (widget.userMissions!
                  .where((e) => e.missionId == widget.mission?.id)
                  .toList()
                  .isNotEmpty
              ? true
              : false) {
            await UserMissionsTable().delete(
              matchingRows: (rows) => rows
                  .eqOrNull(
                    'user_id',
                    currentUserUid,
                  )
                  .eqOrNull(
                    'mission_id',
                    widget.mission?.id,
                  ),
            );
            FFAppState().clearProfileCache();
            FFAppState().clearMissionsCache();
            _model.completed = !_model.completed;
            _model.updatePage(() {});
            if (animationsMap['containerOnActionTriggerAnimation'] != null) {
              await animationsMap['containerOnActionTriggerAnimation']!
                  .controller
                  .forward(from: 0.0);
            }
          } else {
            await UserMissionsTable().insert({
              'user_id': currentUserUid,
              'mission_id': widget.mission?.id,
            });
            FFAppState().clearProfileCache();
            FFAppState().clearMissionsCache();
            _model.completed = !_model.completed;
            _model.updatePage(() {});
            if (animationsMap['containerOnActionTriggerAnimation'] != null) {
              await animationsMap['containerOnActionTriggerAnimation']!
                  .controller
                  .forward(from: 0.0);
            }
            await showDialog(
              barrierColor: const Color(0x7F000000),
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  elevation: 0,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alignment: const AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  child: const MissionCompleteWidget(),
                );
              },
            );
          }
        },
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 60.0,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Builder(
                builder: (context) => ToggleIcon(
                  onPressed: () async {
                    safeSetState(() => _model.completed = !_model.completed);
                    HapticFeedback.heavyImpact();
                    if (widget.userMissions!
                            .where((e) => e.missionId == widget.mission?.id)
                            .toList()
                            .isNotEmpty
                        ? true
                        : false) {
                      await UserMissionsTable().delete(
                        matchingRows: (rows) => rows
                            .eqOrNull(
                              'user_id',
                              currentUserUid,
                            )
                            .eqOrNull(
                              'mission_id',
                              widget.mission?.id,
                            ),
                      );
                      FFAppState().clearProfileCache();
                      FFAppState().clearMissionsCache();
                      if (animationsMap['containerOnActionTriggerAnimation'] !=
                          null) {
                        await animationsMap[
                                'containerOnActionTriggerAnimation']!
                            .controller
                            .forward(from: 0.0);
                      }
                    } else {
                      await UserMissionsTable().insert({
                        'user_id': currentUserUid,
                        'mission_id': widget.mission?.id,
                      });
                      FFAppState().clearProfileCache();
                      FFAppState().clearMissionsCache();
                      if (animationsMap['containerOnActionTriggerAnimation'] !=
                          null) {
                        await animationsMap[
                                'containerOnActionTriggerAnimation']!
                            .controller
                            .forward(from: 0.0);
                      }
                      await showDialog(
                        barrierColor: const Color(0x7F000000),
                        context: context,
                        builder: (dialogContext) {
                          return Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            alignment: const AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: const MissionCompleteWidget(),
                          );
                        },
                      );
                    }
                  },
                  value: _model.completed,
                  onIcon: FaIcon(
                    FontAwesomeIcons.solidCheckCircle,
                    color: FlutterFlowTheme.of(context).success,
                    size: 24.0,
                  ),
                  offIcon: Icon(
                    Icons.circle_outlined,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.missionTitle,
                          'This is the second church challenge',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: FFLocalizations.of(context).getText(
                                'fvnotrch' /* Completed by  */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            TextSpan(
                              text: formatNumber(
                                widget.mission!.peopleCompleted!,
                                formatType: FormatType.compact,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            TextSpan(
                              text: FFLocalizations.of(context).getText(
                                '6l92bhki' /*  people */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            )
                          ],
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ].divide(const SizedBox(height: 4.0)),
                  ),
                ),
              ),
            ]
                .divide(const SizedBox(width: 10.0))
                .addToStart(const SizedBox(width: 12.0))
                .addToEnd(const SizedBox(width: 12.0)),
          ),
        ),
      ).animateOnActionTrigger(
        animationsMap['containerOnActionTriggerAnimation']!,
      ),
    );
  }
}
