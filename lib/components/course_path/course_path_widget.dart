import '/backend/supabase/supabase.dart';
import '/components/course_path_loading/course_path_loading_widget.dart';
import '/components/start_lesson/start_lesson_widget.dart';
import '/components/start_lesson_closed/start_lesson_closed_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'course_path_model.dart';
export 'course_path_model.dart';

class CoursePathWidget extends StatefulWidget {
  const CoursePathWidget({
    super.key,
    required this.course,
    required this.colorCode,
    required this.lessons,
    required this.ulps,
  });

  final CoursesRow? course;
  final String? colorCode;
  final List<CourseLessonsRow>? lessons;
  final List<UserLessonProgressRow>? ulps;

  @override
  State<CoursePathWidget> createState() => _CoursePathWidgetState();
}

class _CoursePathWidgetState extends State<CoursePathWidget>
    with TickerProviderStateMixin {
  late CoursePathModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoursePathModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          for (int loop1Index = 0;
              loop1Index < widget.lessons!.length;
              loop1Index++) {
            final currentLoop1Item = widget.lessons![loop1Index];
            // Add to lessonIds
            _model.addToLessonIds(currentLoop1Item.id);
            safeSetState(() {});
          }
        }),
        Future(() async {
          for (int loop2Index = 0;
              loop2Index < widget.ulps!.length;
              loop2Index++) {
            final currentLoop2Item = widget.ulps![loop2Index];
            // Add Id to ULP
            _model.addToUlpIds(currentLoop2Item.lessonId!);
            safeSetState(() {});
          }
        }),
      ]);
      for (int loop3Index = 0;
          loop3Index < _model.lessonIds.length;
          loop3Index++) {
        final currentLoop3Item = _model.lessonIds[loop3Index];
        if (_model.ulpIds.contains(currentLoop3Item.toString()) &&
            (loop3Index != 0)) {
          if (widget.ulps?.elementAtOrNull(loop3Index)?.status ==
              'completed') {
            // Add Id to completed lessons
            _model.addToCompletedLessonIds(currentLoop3Item);
            safeSetState(() {});
          }
        } else {
          if (widget.ulps
                  ?.elementAtOrNull(functions.nMinusOne(loop3Index)!)
                  ?.status ==
              'completed') {
            // Add Id to completed lessons
            _model.addToCompletedLessonIds(_model.lessonIds
                .elementAtOrNull(functions.nMinusOne(loop3Index)!)!);
            safeSetState(() {});
          } else {
            // Add Id to locked lessons
            _model.addToLockedLessonIds(currentLoop3Item);
            safeSetState(() {});
          }
        }
      }
    });

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.1, 1.1),
          ),
          ScaleEffect(
            curve: Curves.easeOut,
            delay: 800.0.ms,
            duration: 800.0.ms,
            begin: Offset(1.1, 1.1),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    // On component dispose action.
    () async {
      for (int loop1Index = 0;
          loop1Index < widget.lessons!.length;
          loop1Index++) {
        final currentLoop1Item = widget.lessons![loop1Index];
        // Add to lessonIds
        _model.addToLessonIds(currentLoop1Item.id);
        safeSetState(() {});
      }
    }();

    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final lessonList = widget.lessons!.toList();
        if (lessonList.isEmpty) {
          return CoursePathLoadingWidget();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(lessonList.length, (lessonListIndex) {
            final lessonListItem = lessonList[lessonListIndex];
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  valueOrDefault<double>(
                    () {
                      if (lessonListIndex == 0) {
                        return 0.0;
                      } else if (functions.isIntEven(lessonListIndex)) {
                        return 80.0;
                      } else {
                        return 0.0;
                      }
                    }(),
                    0.0,
                  ),
                  0.0,
                  valueOrDefault<double>(
                    () {
                      if (lessonListIndex == 0) {
                        return 0.0;
                      } else if (!functions.isIntEven(lessonListIndex)) {
                        return 80.0;
                      } else {
                        return 0.0;
                      }
                    }(),
                    0.0,
                  ),
                  0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (_model.lockedLessonIds.contains(lessonListItem.id) &&
                      (lessonListIndex != 0)) {
                    HapticFeedback.lightImpact();
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: StartLessonClosedWidget(
                            lesson: lessonListItem,
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  } else {
                    HapticFeedback.lightImpact();
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: StartLessonWidget(
                            lesson: lessonListItem,
                            colorCode: widget.colorCode!,
                            startLesson: () async {
                              if (lessonListItem.type == 'horizontal_video') {
                                _model.horResource =
                                    await ResourcesTable().queryRows(
                                  queryFn: (q) => q.eqOrNull(
                                    'id',
                                    lessonListItem.mediaResourceId,
                                  ),
                                );

                                context.pushNamed(
                                  HorizontalVideoPlayerWidget.routeName,
                                  queryParameters: {
                                    'lesson': serializeParam(
                                      lessonListItem,
                                      ParamType.SupabaseRow,
                                    ),
                                    'courseName': serializeParam(
                                      widget.course?.title,
                                      ParamType.String,
                                    ),
                                    'course': serializeParam(
                                      widget.course,
                                      ParamType.SupabaseRow,
                                    ),
                                    'resource': serializeParam(
                                      _model.horResource?.firstOrNull,
                                      ParamType.SupabaseRow,
                                    ),
                                  }.withoutNulls,
                                );
                              } else {
                                context.pushNamed(
                                  LessonWidget.routeName,
                                  queryParameters: {
                                    'lesson': serializeParam(
                                      lessonListItem,
                                      ParamType.SupabaseRow,
                                    ),
                                    'courseName': serializeParam(
                                      widget.course?.title,
                                      ParamType.String,
                                    ),
                                    'noPages': serializeParam(
                                      lessonListItem.noOfPages,
                                      ParamType.int,
                                    ),
                                    'course': serializeParam(
                                      widget.course,
                                      ParamType.SupabaseRow,
                                    ),
                                  }.withoutNulls,
                                );
                              }
                            },
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  }

                  safeSetState(() {});
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (() {
                      if (_model.lockedLessonIds.contains(lessonListItem.id) &&
                          (lessonListIndex != 0)) {
                        return false;
                      } else if (_model.completedLessonIds
                          .contains(lessonListItem.id)) {
                        return false;
                      } else {
                        return true;
                      }
                    }())
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 78.0,
                                  height: 78.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xFFF99F62),
                                      width: 4.0,
                                    ),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'containerOnPageLoadAnimation']!),
                                Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                    color: colorFromCssString(
                                      widget.colorCode!,
                                      defaultColor: FlutterFlowTheme.of(context)
                                          .secondary,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.star_rounded,
                                      color: Colors.white,
                                      size: 45.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              valueOrDefault<String>(
                                lessonListItem.title,
                                'What is the Gospel?',
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                    if (_model.completedLessonIds.contains(lessonListItem.id)
                        ? true
                        : false)
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: colorFromCssString(
                                  widget.colorCode!,
                                  defaultColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.star_rounded,
                                color: Colors.white,
                                size: 45.0,
                              ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                lessonListItem.title,
                                'What is the Gospel?',
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                    if (_model.lockedLessonIds.contains(lessonListItem.id) &&
                            (lessonListIndex != 0)
                        ? true
                        : false)
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.lock,
                                color: FlutterFlowTheme.of(context).navIcons,
                                size: 40.0,
                              ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                lessonListItem.title,
                                'What is the Gospel?',
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                  ].addToEnd(SizedBox(height: 50.0)),
                ),
              ),
            );
          }).divide(SizedBox(height: 25.0)).addToEnd(SizedBox(height: 40.0)),
        );
      },
    );
  }
}
