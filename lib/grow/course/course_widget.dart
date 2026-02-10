import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'course_model.dart';
export 'course_model.dart';

class CourseWidget extends StatefulWidget {
  const CourseWidget({
    super.key,
    required this.course,
  });

  final CoursesRow? course;

  static String routeName = 'course';
  static String routePath = 'course';

  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  late CourseModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CourseModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'course'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // Get ULPS
      _model.ulps = await UserLessonProgressTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'course_id',
              widget.course?.id,
            )
            .eqOrNull(
              'user_id',
              currentUserUid,
            )
            .order('created_at', ascending: true),
      );
      // Get Lessons
      _model.lessons = await CourseLessonsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'course_id',
              widget.course?.id,
            )
            .order('sort_order', ascending: true),
      );
      await Future.wait([
        Future(() async {
          for (int loop1Index = 0;
              loop1Index < _model.lessons!.length;
              loop1Index++) {
            final currentLoop1Item = _model.lessons![loop1Index];
            // Add Id to lessonIds
            _model.addToLessonIds(currentLoop1Item.id);
            safeSetState(() {});
          }
        }),
        Future(() async {
          for (int loop2Index = 0;
              loop2Index < _model.ulps!.length;
              loop2Index++) {
            final currentLoop2Item = _model.ulps![loop2Index];
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
        if (_model.ulpIds.contains(currentLoop3Item) && (loop3Index != 0)) {
          if (_model.ulps?.elementAtOrNull(loop3Index)?.status == 'completed') {
            // Add Id to completed lessons
            _model.addToCompletedLessonIds(currentLoop3Item);
            safeSetState(() {});
          }
        } else {
          if (_model.ulps
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
              'course_id',
              widget.course?.id,
            )
            .eqOrNull(
              'user_id',
              currentUserUid,
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
        List<UserCourseProgressRow> courseUserCourseProgressRowList =
            snapshot.data!;

        final courseUserCourseProgressRow =
            courseUserCourseProgressRowList.isNotEmpty
                ? courseUserCourseProgressRowList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: valueOrDefault<String>(
                          widget.course?.thumbnailUrl,
                          'https://saltandlight.sg/wp-content/uploads/2022/02/pexels-charlotte-may-5966005-scaled.jpg',
                        ),
                        transitionOnUserGestures: true,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 100),
                            fadeOutDuration: Duration(milliseconds: 100),
                            imageUrl: valueOrDefault<String>(
                              widget.course?.thumbnailUrl,
                              'https://saltandlight.sg/wp-content/uploads/2022/02/pexels-charlotte-may-5966005-scaled.jpg',
                            ),
                            width: double.infinity,
                            height: 250.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.safePop();
                                    },
                                    child: Container(
                                      width: 34.0,
                                      height: 34.0,
                                      decoration: BoxDecoration(
                                        color: Color(0x7F000000),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                                if (widget.course?.type == 'video')
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x7F000000),
                                      borderRadius: BorderRadius.circular(24.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          6.0, 0.0, 6.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 16.0,
                                          ),
                                          Text(
                                            'Video Course',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 2.0)),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            widget.course?.title,
                            'Calm Your Mind and Body',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                                    lineHeight: 1.2,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 6.0, 0.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              widget.course?.subtitle,
                              'Use mindfulness to accept anxious feelings without being controlled by  hem.',
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                  lineHeight: 1.2,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: LinearPercentIndicator(
                                  percent: functions.coursePercantage(
                                      courseUserCourseProgressRow != null
                                          ? courseUserCourseProgressRow
                                              .lessonsCompleted!
                                          : 0,
                                      courseUserCourseProgressRow != null
                                          ? courseUserCourseProgressRow
                                              .totalLessons!
                                          : 1),
                                  lineHeight: 6.0,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor:
                                      FlutterFlowTheme.of(context).secondary,
                                  backgroundColor: Color(0xFFDFDFDF),
                                  barRadius: Radius.circular(12.0),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                              Text(
                                '${formatNumber(
                                  functions.coursePercantage(
                                      courseUserCourseProgressRow != null
                                          ? courseUserCourseProgressRow
                                              .lessonsCompleted!
                                          : 0,
                                      courseUserCourseProgressRow != null
                                          ? courseUserCourseProgressRow
                                              .totalLessons!
                                          : 1),
                                  formatType: FormatType.percent,
                                )}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(SizedBox(width: 12.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              final lessonList = _model.lessons?.toList() ?? [];

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(lessonList.length,
                                    (lessonListIndex) {
                                  final lessonListItem =
                                      lessonList[lessonListIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (!(_model.lockedLessonIds
                                              .contains(lessonListItem.id) &&
                                          (lessonListIndex != 0))) {
                                        HapticFeedback.lightImpact();
                                        if (lessonListItem.type ==
                                            'vertical_video') {
                                          _model.verResource =
                                              await ResourcesTable().queryRows(
                                            queryFn: (q) => q.eqOrNull(
                                              'id',
                                              lessonListItem.mediaResourceId,
                                            ),
                                          );

                                          context.pushNamed(
                                            VerticalVideoPlayerWidget.routeName,
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
                                                _model.verResource?.firstOrNull,
                                                ParamType.SupabaseRow,
                                              ),
                                            }.withoutNulls,
                                          );
                                        } else if (lessonListItem.type ==
                                            'horizontal_video') {
                                          _model.horResource =
                                              await ResourcesTable().queryRows(
                                            queryFn: (q) => q.eqOrNull(
                                              'id',
                                              lessonListItem.mediaResourceId,
                                            ),
                                          );

                                          context.pushNamed(
                                            HorizontalVideoPlayerWidget
                                                .routeName,
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
                                      }

                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minHeight: 105.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
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
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .dfdfdf,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (() {
                                                    if (_model.lockedLessonIds
                                                            .contains(
                                                                lessonListItem
                                                                    .id) &&
                                                        (lessonListIndex !=
                                                            0)) {
                                                      return false;
                                                    } else if (_model
                                                        .completedLessonIds
                                                        .contains(lessonListItem
                                                            .id)) {
                                                      return false;
                                                    } else {
                                                      return true;
                                                    }
                                                  }())
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  6.0),
                                                      child: Container(
                                                        width: 70.0,
                                                        height: 22.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x326A55EA),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          'Unlocked',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (_model.completedLessonIds
                                                          .contains(
                                                              lessonListItem.id)
                                                      ? true
                                                      : false)
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  6.0),
                                                      child: Container(
                                                        width: 70.0,
                                                        height: 22.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFDDECD5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          'Completed',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFF5C9342),
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (_model.lockedLessonIds
                                                              .contains(
                                                                  lessonListItem
                                                                      .id) &&
                                                          (lessonListIndex != 0)
                                                      ? true
                                                      : false)
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  6.0),
                                                      child: Container(
                                                        width: 70.0,
                                                        height: 22.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFFEE2E1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          'Locked',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFF13A28),
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 4.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        lessonListItem.title,
                                                        'Stop Fighting Your Anxiety',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 4.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        lessonListItem
                                                            .description,
                                                        'Learn why tryong to control anxiety often makes in worse',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                                lineHeight: 1.2,
                                                              ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.clock,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        size: 12.0,
                                                      ),
                                                      Text(
                                                        '${valueOrDefault<String>(
                                                          lessonListItem
                                                              .estimatedMinutes
                                                              ?.toString(),
                                                          '3',
                                                        )} mins',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 13.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 3.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    ),
                                  );
                                }).divide(SizedBox(height: 12.0)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ].addToEnd(SizedBox(height: 70.0)),
              ),
            ),
          ),
        );
      },
    );
  }
}
