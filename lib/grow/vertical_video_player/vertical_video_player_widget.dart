import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'vertical_video_player_model.dart';
export 'vertical_video_player_model.dart';

class VerticalVideoPlayerWidget extends StatefulWidget {
  const VerticalVideoPlayerWidget({
    super.key,
    required this.lesson,
    required this.courseName,
    required this.course,
    required this.resource,
  });

  final CourseLessonsRow? lesson;
  final String? courseName;
  final CoursesRow? course;
  final ResourcesRow? resource;

  static String routeName = 'verticalVideoPlayer';
  static String routePath = 'verticalVideoPlayer';

  @override
  State<VerticalVideoPlayerWidget> createState() =>
      _VerticalVideoPlayerWidgetState();
}

class _VerticalVideoPlayerWidgetState extends State<VerticalVideoPlayerWidget> {
  late VerticalVideoPlayerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerticalVideoPlayerModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'verticalVideoPlayer'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserCourseProgressRow>>(
      future: UserCourseProgressTable().querySingleRow(
        queryFn: (q) => q
            .eqOrNull(
              'user_id',
              currentUserUid,
            )
            .eqOrNull(
              'course_id',
              widget.course?.id,
            ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black,
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
        List<UserCourseProgressRow>
            verticalVideoPlayerUserCourseProgressRowList = snapshot.data!;

        final verticalVideoPlayerUserCourseProgressRow =
            verticalVideoPlayerUserCourseProgressRowList.isNotEmpty
                ? verticalVideoPlayerUserCourseProgressRowList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: custom_widgets.CustomVidPlayer(
                              width: double.infinity,
                              height: double.infinity,
                              videoPath: widget.resource!.mediaUrl!,
                              videoComplete: () async {
                                var _shouldSetState = false;
                                unawaited(
                                  () async {
                                    await XpEventsTable().insert({
                                      'user_id': currentUserUid,
                                      'delta': widget.lesson?.xpReward,
                                      'reason': 'lesson complete',
                                      'idempotency_key': widget.lesson?.id,
                                    });
                                  }(),
                                );
                                await UserLessonProgressTable().update(
                                  data: {
                                    'lesson_id': widget.lesson?.id,
                                    'completed_at': supaSerialize<DateTime>(
                                        getCurrentTimestamp),
                                    'status': 'completed',
                                  },
                                  matchingRows: (rows) => rows
                                      .eqOrNull(
                                        'lesson_id',
                                        widget.lesson?.id,
                                      )
                                      .eqOrNull(
                                        'user_id',
                                        currentUserUid,
                                      )
                                      .eqOrNull(
                                        'course_id',
                                        widget.lesson?.courseId,
                                      ),
                                );
                                _model.currentCompletedLessons =
                                    verticalVideoPlayerUserCourseProgressRow
                                        ?.lessonsCompleted;
                                safeSetState(() {});
                                if (_model.currentCompletedLessons !=
                                    verticalVideoPlayerUserCourseProgressRow
                                        ?.totalLessons) {
                                  _model.currentCompletedLessons =
                                      _model.currentCompletedLessons! + 1;
                                  safeSetState(() {});
                                  await UserCourseProgressTable().update(
                                    data: {
                                      'lessons_completed':
                                          _model.currentCompletedLessons,
                                    },
                                    matchingRows: (rows) => rows
                                        .eqOrNull(
                                          'user_id',
                                          currentUserUid,
                                        )
                                        .eqOrNull(
                                          'course_id',
                                          widget.lesson?.courseId,
                                        ),
                                  );
                                  _shouldSetState = true;
                                }
                                if (_model.ucp?.firstOrNull?.lessonsCompleted ==
                                    _model.ucp?.firstOrNull?.totalLessons) {
                                  await UserCourseProgressTable().update(
                                    data: {
                                      'status': 'completed',
                                      'completed_at': supaSerialize<DateTime>(
                                          getCurrentTimestamp),
                                    },
                                    matchingRows: (rows) => rows
                                        .eqOrNull(
                                          'user_id',
                                          currentUserUid,
                                        )
                                        .eqOrNull(
                                          'course_id',
                                          widget.lesson?.courseId,
                                        ),
                                  );
                                  await action_blocks.calculateStreak(context);
                                  if (widget.lesson!.hasMission!) {
                                    _model.mission1 =
                                        await MissionsCatalogTable().queryRows(
                                      queryFn: (q) => q.eqOrNull(
                                        'lesson_id',
                                        widget.lesson?.id,
                                      ),
                                    );
                                    _shouldSetState = true;

                                    context.goNamed(
                                      NewMissionWidget.routeName,
                                      queryParameters: {
                                        'mission': serializeParam(
                                          _model.mission1?.firstOrNull,
                                          ParamType.SupabaseRow,
                                        ),
                                        'lessonXp': serializeParam(
                                          widget.lesson?.xpReward,
                                          ParamType.int,
                                        ),
                                        'target': serializeParam(
                                          'course',
                                          ParamType.String,
                                        ),
                                        'course': serializeParam(
                                          widget.course,
                                          ParamType.SupabaseRow,
                                        ),
                                      }.withoutNulls,
                                    );
                                  } else {
                                    context.goNamed(
                                      CourseCompleteWidget.routeName,
                                      queryParameters: {
                                        'lessonXp': serializeParam(
                                          widget.lesson?.xpReward,
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  }

                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                } else {
                                  await action_blocks.calculateStreak(context);
                                  if (widget.lesson!.hasMission!) {
                                    _model.mission2 =
                                        await MissionsCatalogTable().queryRows(
                                      queryFn: (q) => q.eqOrNull(
                                        'lesson_id',
                                        widget.lesson?.id,
                                      ),
                                    );
                                    _shouldSetState = true;

                                    context.goNamed(
                                      NewMissionWidget.routeName,
                                      queryParameters: {
                                        'mission': serializeParam(
                                          _model.mission2?.firstOrNull,
                                          ParamType.SupabaseRow,
                                        ),
                                        'lessonXp': serializeParam(
                                          widget.lesson?.xpReward,
                                          ParamType.int,
                                        ),
                                        'target': serializeParam(
                                          'lesson',
                                          ParamType.String,
                                        ),
                                        'course': serializeParam(
                                          widget.course,
                                          ParamType.SupabaseRow,
                                        ),
                                      }.withoutNulls,
                                    );
                                  } else {
                                    context.goNamed(
                                      LessonCompleteWidget.routeName,
                                      queryParameters: {
                                        'lessonXp': serializeParam(
                                          widget.lesson?.xpReward,
                                          ParamType.int,
                                        ),
                                        'course': serializeParam(
                                          widget.course,
                                          ParamType.SupabaseRow,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  }

                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }

                                if (_shouldSetState) safeSetState(() {});
                              },
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 64.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            widget.lesson?.title,
                                            'Practice Mindfulness',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            widget.course?.title,
                                            'Calm Your Mind and Body',
                                          ),
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 6.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 0.0, 0.0),
                            child: SafeArea(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 40.0,
                                  fillColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    context.safePop();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
