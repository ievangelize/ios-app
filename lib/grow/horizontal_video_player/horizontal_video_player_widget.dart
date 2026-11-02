import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/tap_to_complete_btn/tap_to_complete_btn_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'horizontal_video_player_model.dart';
export 'horizontal_video_player_model.dart';

class HorizontalVideoPlayerWidget extends StatefulWidget {
  const HorizontalVideoPlayerWidget({
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

  static String routeName = 'horizontalVideoPlayer';
  static String routePath = 'horizontalVideoPlayer';

  @override
  State<HorizontalVideoPlayerWidget> createState() =>
      _HorizontalVideoPlayerWidgetState();
}

class _HorizontalVideoPlayerWidgetState
    extends State<HorizontalVideoPlayerWidget> {
  late HorizontalVideoPlayerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HorizontalVideoPlayerModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'horizontalVideoPlayer'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.ulp = await UserLessonProgressTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'user_id',
              currentUserUid,
            )
            .eqOrNull(
              'lesson_id',
              widget.lesson?.id,
            ),
      );
      if (!(_model.ulp != null && (_model.ulp)!.isNotEmpty)) {
        await UserLessonProgressTable().insert({
          'user_id': currentUserUid,
          'lesson_id': widget.lesson?.id,
          'status': 'in_progress',
          'started_at': supaSerialize<DateTime>(getCurrentTimestamp),
          'course_id': widget.course?.id,
        });
      }
      _model.ucpCopy = await UserCourseProgressTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'course_id',
              widget.course?.id,
            )
            .eqOrNull(
              'user_id',
              currentUserUid,
            ),
      );
      if (_model.ucpCopy != null && (_model.ucpCopy)!.isNotEmpty) {
        await UserCourseProgressTable().update(
          data: {
            'last_engaged_at': supaSerialize<DateTime>(getCurrentTimestamp),
          },
          matchingRows: (rows) => rows
              .eqOrNull(
                'user_id',
                currentUserUid,
              )
              .eqOrNull(
                'course_id',
                widget.course?.id,
              ),
        );
      } else {
        await UserCourseProgressTable().insert({
          'user_id': currentUserUid,
          'course_id': widget.course?.id,
          'status': 'in_progress',
          'lessons_completed': 0,
          'total_lessons': widget.course?.totalLessons,
          'started_at': supaSerialize<DateTime>(getCurrentTimestamp),
          'last_engaged_at': supaSerialize<DateTime>(getCurrentTimestamp),
        });
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
        List<UserCourseProgressRow>
            horizontalVideoPlayerUserCourseProgressRowList = snapshot.data!;

        final horizontalVideoPlayerUserCourseProgressRow =
            horizontalVideoPlayerUserCourseProgressRowList.isNotEmpty
                ? horizontalVideoPlayerUserCourseProgressRowList.first
                : null;

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
                  context.safePop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 231.5,
                      child: custom_widgets.ChewieVideoPlayer(
                        width: double.infinity,
                        height: 231.5,
                        videoURL: widget.resource!.mediaUrl!,
                        backgroundAudioTitle: widget.lesson!.title!,
                        backgroundAudioArtist: widget.course!.title!,
                        backgroundAudioArtwork: widget.resource!.thumbnailUrl!,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              widget.lesson?.title,
                              'Understanding Apologetics',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.lesson?.description,
                                'Lesson Description',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 24.0, 0.0, 0.0),
                            child: wrapWithModel(
                              model: _model.tapToCompleteBtnModel,
                              updateCallback: () => safeSetState(() {}),
                              child: TapToCompleteBtnWidget(
                                action: () async {
                                  var _shouldSetState = false;
                                  FFAppState().exploreUcpIdsJson = [];
                                  safeSetState(() {});
                                  if (_model.ulp?.firstOrNull?.status ==
                                          'completed'
                                      ? false
                                      : true) {
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
                                        horizontalVideoPlayerUserCourseProgressRow
                                            ?.lessonsCompleted;
                                    safeSetState(() {});
                                    if (_model.currentCompletedLessons !=
                                        horizontalVideoPlayerUserCourseProgressRow
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
                                    if (_model.currentCompletedLessons ==
                                        horizontalVideoPlayerUserCourseProgressRow
                                            ?.totalLessons) {
                                      await UserCourseProgressTable().update(
                                        data: {
                                          'status': 'completed',
                                          'completed_at':
                                              supaSerialize<DateTime>(
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
                                      unawaited(
                                        () async {
                                          await XpEventsTable().insert({
                                            'user_id': currentUserUid,
                                            'delta': widget.course?.xpReward,
                                            'reason': 'course complete',
                                            'idempotency_key':
                                                widget.lesson?.id,
                                          });
                                        }(),
                                      );
                                      await action_blocks
                                          .calculateStreak(context);
                                      if (widget.lesson!.hasMission!) {
                                        _model.mission1 =
                                            await MissionsCatalogTable()
                                                .queryRows(
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
                                              functions.totalXP(
                                                  widget.course!.xpReward!,
                                                  widget.lesson!.xpReward!),
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

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      } else {
                                        context.goNamed(
                                          CourseCompleteWidget.routeName,
                                          queryParameters: {
                                            'lessonXp': serializeParam(
                                              functions.totalXP(
                                                  widget.course!.xpReward!,
                                                  widget.lesson!.xpReward!),
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            '__transition_info__':
                                                TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }
                                    }
                                  }
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
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'More about',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: FutureBuilder<List<ResourceProvidersRow>>(
                              future: ResourceProvidersTable().querySingleRow(
                                queryFn: (q) => q.eqOrNull(
                                  'id',
                                  widget.resource?.provider,
                                ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: SpinKitFadingCircle(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 20.0,
                                      ),
                                    ),
                                  );
                                }
                                List<ResourceProvidersRow>
                                    containerResourceProvidersRowList =
                                    snapshot.data!;

                                final containerResourceProvidersRow =
                                    containerResourceProvidersRowList.isNotEmpty
                                        ? containerResourceProvidersRowList
                                            .first
                                        : null;

                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      ResourceCreditWidget.routeName,
                                      queryParameters: {
                                        'provider': serializeParam(
                                          containerResourceProvidersRow,
                                          ParamType.SupabaseRow,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 10.0, 16.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                                  Duration(milliseconds: 300),
                                              fadeOutDuration:
                                                  Duration(milliseconds: 300),
                                              imageUrl: valueOrDefault<String>(
                                                containerResourceProvidersRow
                                                    ?.logoUrl,
                                                'https://api.ievangelize.app/storage/v1/object/public/resources/ievangelize/images/ievangelize%20logo.png',
                                              ),
                                              width: 60.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                valueOrDefault<String>(
                                                  containerResourceProvidersRow
                                                      ?.name,
                                                  'Provider name',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                              ),
                                              Text(
                                                'Resource Provider',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                          Flexible(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: Icon(
                                                Icons.chevron_right_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 28.0,
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 16.0)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].addToEnd(SizedBox(height: 100.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
