import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/quiz_option_multi/quiz_option_multi_widget.dart';
import '/components/quiz_option_single/quiz_option_single_widget.dart';
import '/components/streak/streak_widget.dart';
import '/components/tap_to_complete_btn/tap_to_complete_btn_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lesson_model.dart';
export 'lesson_model.dart';

class LessonWidget extends StatefulWidget {
  const LessonWidget({
    super.key,
    required this.lesson,
    required this.courseName,
    int? noPages,
    required this.course,
  }) : this.noPages = noPages ?? 0;

  final CourseLessonsRow? lesson;
  final String? courseName;
  final int noPages;
  final CoursesRow? course;

  static String routeName = 'lesson';
  static String routePath = 'lesson';

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  late LessonModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LessonModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'lesson'});
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
          'course_id': widget.lesson?.courseId,
        });
      }
      for (int loop1Index = 0;
          loop1Index <
              List.generate(widget.noPages, (index) => index + 1).length;
          loop1Index++) {
        final currentLoop1Item =
            List.generate(widget.noPages, (index) => index + 1)[loop1Index];
        _model.addToNoPagesList(currentLoop1Item);
        safeSetState(() {});
      }
      _model.ucp = await UserCourseProgressTable().queryRows(
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
      if (_model.ucp != null && (_model.ucp)!.isNotEmpty) {
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
    context.watch<FFAppState>();

    return FutureBuilder<List<UserCourseProgressRow>>(
      future: UserCourseProgressTable().querySingleRow(
        queryFn: (q) => q
            .eqOrNull(
              'user_id',
              currentUserUid,
            )
            .eqOrNull(
              'course_id',
              widget.lesson?.courseId,
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
        List<UserCourseProgressRow> lessonUserCourseProgressRowList =
            snapshot.data!;

        final lessonUserCourseProgressRow =
            lessonUserCourseProgressRowList.isNotEmpty
                ? lessonUserCourseProgressRowList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SafeArea(
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final pages = _model.noPagesList.toList();

                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.generate(pages.length,
                                          (pagesIndex) {
                                        final pagesItem = pages[pagesIndex];
                                        return Expanded(
                                          child: Container(
                                            height: 5.0,
                                            decoration: BoxDecoration(
                                              color: valueOrDefault<Color>(
                                                pagesItem <= _model.currentPage
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .secondary
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .accent1,
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                          ),
                                        );
                                      }).divide(SizedBox(width: 4.0)),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? 'assets/images/logo_white.png'
                                                : 'assets/images/logo_dark_(2).png',
                                            height: 22.0,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 6.0)),
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 20.0,
                                      buttonSize: 32.0,
                                      fillColor:
                                          FlutterFlowTheme.of(context).accent2,
                                      icon: Icon(
                                        Icons.close,
                                        color: FlutterFlowTheme.of(context)
                                            .blackWhite,
                                        size: 16.0,
                                      ),
                                      onPressed: () async {
                                        context.safePop();
                                      },
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            valueOrDefault<String>(
                                              widget.lesson?.title,
                                              'Stop Fighting Your Anxiety',
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
                                                  fontSize: 17.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              widget.courseName,
                                              'Calm Your Mind and Body',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0),
                            ),
                          ),
                          child: FutureBuilder<List<LessonPagesRow>>(
                            future: LessonPagesTable().queryRows(
                              queryFn: (q) => q
                                  .eqOrNull(
                                    'lesson_id',
                                    widget.lesson?.id,
                                  )
                                  .order('sort_order', ascending: true),
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
                              List<LessonPagesRow> pageViewLessonPagesRowList =
                                  snapshot.data!;

                              return Container(
                                width: double.infinity,
                                height: 500.0,
                                child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: _model.pageViewController ??=
                                      PageController(
                                          initialPage: max(
                                              0,
                                              min(
                                                  0,
                                                  pageViewLessonPagesRowList
                                                          .length -
                                                      1))),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: pageViewLessonPagesRowList.length,
                                  itemBuilder: (context, pageViewIndex) {
                                    final pageViewLessonPagesRow =
                                        pageViewLessonPagesRowList[
                                            pageViewIndex];
                                    return Stack(
                                      children: [
                                        if (pageViewLessonPagesRow.type !=
                                            'content')
                                          FutureBuilder<List<QuizzesRow>>(
                                            future: _model.quiz(
                                              uniqueQueryKey:
                                                  pageViewLessonPagesRow.id,
                                              requestFn: () =>
                                                  QuizzesTable().querySingleRow(
                                                queryFn: (q) => q.eqOrNull(
                                                  'page_id',
                                                  pageViewLessonPagesRow.id,
                                                ),
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<QuizzesRow>
                                                  containerQuizQuizzesRowList =
                                                  snapshot.data!;

                                              final containerQuizQuizzesRow =
                                                  containerQuizQuizzesRowList
                                                          .isNotEmpty
                                                      ? containerQuizQuizzesRowList
                                                          .first
                                                      : null;

                                              return Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(24.0),
                                                    topRight:
                                                        Radius.circular(24.0),
                                                  ),
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent1,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            containerQuizQuizzesRow
                                                                ?.title,
                                                            'The Anxiety Trap',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 20.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      18.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              containerQuizQuizzesRow
                                                                  ?.questionText,
                                                              'When you try to push away an axious feeling, what usually happens?',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.2,
                                                                ),
                                                          ),
                                                        ),
                                                        if (containerQuizQuizzesRow
                                                                ?.quizType ==
                                                            'single')
                                                          FutureBuilder<
                                                              List<
                                                                  QuizOptionsRow>>(
                                                            future: _model
                                                                .quizSingle(
                                                              uniqueQueryKey:
                                                                  valueOrDefault<
                                                                      String>(
                                                                containerQuizQuizzesRow
                                                                    ?.id,
                                                                '1',
                                                              ),
                                                              requestFn: () =>
                                                                  QuizOptionsTable()
                                                                      .queryRows(
                                                                queryFn: (q) =>
                                                                    q.eqOrNull(
                                                                  'quiz_id',
                                                                  containerQuizQuizzesRow
                                                                      ?.id,
                                                                ),
                                                              ),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 20.0,
                                                                    height:
                                                                        20.0,
                                                                    child:
                                                                        SpinKitFadingCircle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<QuizOptionsRow>
                                                                  quizOptionSingleQuizOptionsRowList =
                                                                  snapshot
                                                                      .data!;

                                                              return QuizOptionSingleWidget(
                                                                key: Key(
                                                                    'Keyeyu_${pageViewIndex}_of_${pageViewLessonPagesRowList.length}'),
                                                                quizFeedback:
                                                                    containerQuizQuizzesRow!
                                                                        .answerFeedback!,
                                                                supabaseOptionsList:
                                                                    quizOptionSingleQuizOptionsRowList,
                                                                swipeStack:
                                                                    () async {
                                                                  await _model
                                                                      .pageViewController
                                                                      ?.nextPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            300),
                                                                    curve: Curves
                                                                        .ease,
                                                                  );
                                                                  _model.currentPage =
                                                                      _model.currentPage +
                                                                          1;
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        if (containerQuizQuizzesRow
                                                                ?.quizType ==
                                                            'multi')
                                                          FutureBuilder<
                                                              List<
                                                                  QuizOptionsRow>>(
                                                            future: _model
                                                                .quizMulti(
                                                              uniqueQueryKey:
                                                                  valueOrDefault<
                                                                      String>(
                                                                containerQuizQuizzesRow
                                                                    ?.id,
                                                                '1',
                                                              ),
                                                              requestFn: () =>
                                                                  QuizOptionsTable()
                                                                      .queryRows(
                                                                queryFn: (q) =>
                                                                    q.eqOrNull(
                                                                  'quiz_id',
                                                                  containerQuizQuizzesRow
                                                                      ?.id,
                                                                ),
                                                              ),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 20.0,
                                                                    height:
                                                                        20.0,
                                                                    child:
                                                                        SpinKitFadingCircle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<QuizOptionsRow>
                                                                  quizOptionMultiQuizOptionsRowList =
                                                                  snapshot
                                                                      .data!;

                                                              return QuizOptionMultiWidget(
                                                                key: Key(
                                                                    'Keydp1_${pageViewIndex}_of_${pageViewLessonPagesRowList.length}'),
                                                                quizFeedback:
                                                                    containerQuizQuizzesRow!
                                                                        .answerFeedback!,
                                                                supabaseOptionsList:
                                                                    quizOptionMultiQuizOptionsRowList,
                                                                swipeStack:
                                                                    () async {
                                                                  await _model
                                                                      .pageViewController
                                                                      ?.nextPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            300),
                                                                    curve: Curves
                                                                        .ease,
                                                                  );
                                                                  _model.currentPage =
                                                                      _model.currentPage +
                                                                          1;
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                              );
                                                            },
                                                          ),
                                                      ].addToStart(SizedBox(
                                                          height: 24.0)),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        if (pageViewLessonPagesRow.type ==
                                            'content')
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 500.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        valueOrDefault<String>(
                                                          pageViewLessonPagesRow
                                                              .title,
                                                          'The Paradox of Control',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 21.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                      custom_widgets
                                                          .CustomMarkdown(
                                                        width: double.infinity,
                                                        height: 50.0,
                                                        fontSize: 16.0,
                                                        textColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        blockquoteBackground:
                                                            Color(0x1A6A55EA),
                                                        blockquoteTextColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        data:
                                                            pageViewLessonPagesRow
                                                                .bodyMd!,
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 12.0))
                                                        .addToStart(SizedBox(
                                                            height: 24.0))
                                                        .addToEnd(SizedBox(
                                                            height: 16.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 60.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            HapticFeedback.lightImpact();
                            _model.currentPage = _model.currentPage + -1;
                            safeSetState(() {});
                            await _model.pageViewController?.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          child: Icon(
                            Icons.navigate_before,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 36.0,
                          ),
                        ),
                        if (_model.currentPage == widget.lesson?.noOfPages
                            ? false
                            : true)
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              HapticFeedback.lightImpact();
                              _model.currentPage = _model.currentPage + 1;
                              safeSetState(() {});
                              await _model.pageViewController?.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            child: Icon(
                              Icons.navigate_next,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 36.0,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (_model.currentPage == widget.lesson?.noOfPages
                    ? true
                    : false)
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(80.0, 0.0, 16.0, 50.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Builder(
                            builder: (context) => wrapWithModel(
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
                                        lessonUserCourseProgressRow
                                            ?.lessonsCompleted;
                                    safeSetState(() {});
                                    if (_model.currentCompletedLessons !=
                                        lessonUserCourseProgressRow
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
                                        lessonUserCourseProgressRow
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
                                            'reason': 'course  complete',
                                            'idempotency_key':
                                                widget.course?.id,
                                          });
                                        }(),
                                      );
                                      unawaited(
                                        () async {
                                          await action_blocks
                                              .sendFriendNotification(
                                            context,
                                            eventType: 'course complete',
                                          );
                                        }(),
                                      );
                                      _model.xpEvents2 =
                                          await XpEventsTable().queryRows(
                                        queryFn: (q) => q.eqOrNull(
                                          'user_id',
                                          currentUserUid,
                                        ),
                                      );
                                      _shouldSetState = true;
                                      _model.streak2 =
                                          await actions.calculateStreak(
                                        _model.xpEvents2!
                                            .map((e) => e.createdAt)
                                            .toList(),
                                        FFAppState().currentStreak,
                                      );
                                      _shouldSetState = true;
                                      if (getJsonField(
                                        _model.streak2!.lastOrNull,
                                        r'''$.is_streak''',
                                      )) {
                                        FFAppState().currentStreak =
                                            getJsonField(
                                          _model.streak2!.elementAtOrNull(1),
                                          r'''$.streak''',
                                        );
                                        await UsersTable().update(
                                          data: {
                                            'streak':
                                                FFAppState().currentStreak,
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            currentUserUid,
                                          ),
                                        );
                                        await showDialog(
                                          barrierColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Container(
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  child: StreakWidget(
                                                    streakAmount: getJsonField(
                                                      _model.streak2
                                                          ?.elementAtOrNull(1),
                                                      r'''$.streak''',
                                                    ).toString(),
                                                    streakDays: getJsonField(
                                                      _model
                                                          .streak2?.firstOrNull,
                                                      r'''$.active_days''',
                                                      true,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
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

                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }
                                  }
                                  _model.xpEvents1 =
                                      await XpEventsTable().queryRows(
                                    queryFn: (q) => q.eqOrNull(
                                      'user_id',
                                      currentUserUid,
                                    ),
                                  );
                                  _shouldSetState = true;
                                  _model.streak1 =
                                      await actions.calculateStreak(
                                    _model.xpEvents1!
                                        .map((e) => e.createdAt)
                                        .toList(),
                                    FFAppState().currentStreak,
                                  );
                                  _shouldSetState = true;
                                  if (getJsonField(
                                    _model.streak1!.lastOrNull,
                                    r'''$.is_streak''',
                                  )) {
                                    FFAppState().currentStreak = getJsonField(
                                      _model.streak1!.elementAtOrNull(1),
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
                                      barrierColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
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
                                                streakAmount: getJsonField(
                                                  _model.streak1
                                                      ?.elementAtOrNull(1),
                                                  r'''$.streak''',
                                                ).toString(),
                                                streakDays: getJsonField(
                                                  _model.streak1?.firstOrNull,
                                                  r'''$.active_days''',
                                                  true,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
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
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
