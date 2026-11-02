import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'celebrate_button_model.dart';
export 'celebrate_button_model.dart';

class CelebrateButtonWidget extends StatefulWidget {
  const CelebrateButtonWidget({
    super.key,
    required this.xpEvent,
    this.activityReactionID,
    this.friends,
    required this.celebratorName,
  });

  final XpEventsRow? xpEvent;
  final String? activityReactionID;
  final List<String>? friends;
  final String? celebratorName;

  @override
  State<CelebrateButtonWidget> createState() => _CelebrateButtonWidgetState();
}

class _CelebrateButtonWidgetState extends State<CelebrateButtonWidget>
    with TickerProviderStateMixin {
  late CelebrateButtonModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CelebrateButtonModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.activityReactionID != null &&
          widget.activityReactionID != '') {
        _model.hasCelebrated = true;
        safeSetState(() {});
      } else {
        _model.hasCelebrated = false;
        safeSetState(() {});
      }
    });

    animationsMap.addAll({
      'richTextOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.1, 1.1),
          ),
          ScaleEffect(
            curve: Curves.linear,
            delay: 200.0.ms,
            duration: 200.0.ms,
            begin: Offset(1.1, 1.1),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'richTextOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.1, 1.1),
          ),
          ScaleEffect(
            curve: Curves.linear,
            delay: 200.0.ms,
            duration: 200.0.ms,
            begin: Offset(1.1, 1.1),
            end: Offset(1.0, 1.0),
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
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (_model.hasCelebrated)
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              HapticFeedback.lightImpact();
              if (animationsMap['richTextOnActionTriggerAnimation1'] != null) {
                animationsMap['richTextOnActionTriggerAnimation1']!
                    .controller
                    .forward(from: 0.0);
              }
              _model.hasCelebrated = false;
              safeSetState(() {});
              await ActivityReactionsTable().delete(
                matchingRows: (rows) => rows
                    .eqOrNull(
                      'id',
                      widget.activityReactionID,
                    )
                    .eqOrNull(
                      'user_id',
                      currentUserUid,
                    ),
              );
            },
            child: Container(
              width: 100.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondary,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '🎉',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      TextSpan(
                        text: ' Celebrate',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).info,
                              fontSize: 11.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.0,
                        ),
                  ),
                ).animateOnActionTrigger(
                  animationsMap['richTextOnActionTriggerAnimation1']!,
                ),
              ),
            ),
          ),
        if (!_model.hasCelebrated)
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              HapticFeedback.lightImpact();
              if (animationsMap['richTextOnActionTriggerAnimation2'] != null) {
                animationsMap['richTextOnActionTriggerAnimation2']!
                    .controller
                    .forward(from: 0.0);
              }
              _model.hasCelebrated = true;
              safeSetState(() {});
              _model.newActivity = await ActivityReactionsTable().insert({
                'xp_event_id': widget.xpEvent?.id,
                'user_id': currentUserUid,
                'reaction_type': 'celebrate',
              });
              _model.apiResultfsm = await SendPushNotificationCall.call(
                supabaseToken: FFAppState().SupabaseKey,
                userIdsList: widget.friends,
                title: 'Celebration 🎉',
                body: '${widget.celebratorName}${() {
                  if (widget.xpEvent?.reason == 'mission complete') {
                    return ' celebrates your completed mission!';
                  } else if (widget.xpEvent?.reason == 'lesson complete') {
                    return ' celebrates your completed lesson!';
                  } else if (widget.xpEvent?.reason == 'course complete') {
                    return ' celebrates your completed course!';
                  } else if (widget.xpEvent?.reason == 'new encounter') {
                    return ' celebrates your new encounter!';
                  } else if (widget.xpEvent?.reason == 'prayer') {
                    return ' is thankful for your prayer!';
                  } else {
                    return ' is celebrating with you!';
                  }
                }()}',
              );

              if ((_model.apiResultfsm?.succeeded ?? true)) {
                FFAppState().addToActivityReactions(_model.newActivity!.id!);
                safeSetState(() {});
              } else {
                _model.hasCelebrated = false;
                safeSetState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Something wrong happened',
                      style: TextStyle(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                    duration: Duration(milliseconds: 4000),
                    backgroundColor: FlutterFlowTheme.of(context).error,
                  ),
                );
              }

              safeSetState(() {});
            },
            child: Container(
              width: 100.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).navIcons,
                  width: 1.5,
                ),
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '🎉',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      TextSpan(
                        text: ' Celebrate',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 11.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.0,
                        ),
                  ),
                ).animateOnActionTrigger(
                  animationsMap['richTextOnActionTriggerAnimation2']!,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
