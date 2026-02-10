import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'lesson_complete_model.dart';
export 'lesson_complete_model.dart';

class LessonCompleteWidget extends StatefulWidget {
  const LessonCompleteWidget({
    super.key,
    required this.lessonXp,
    required this.course,
  });

  final int? lessonXp;
  final CoursesRow? course;

  static String routeName = 'lessonComplete';
  static String routePath = 'lessonComplete';

  @override
  State<LessonCompleteWidget> createState() => _LessonCompleteWidgetState();
}

class _LessonCompleteWidgetState extends State<LessonCompleteWidget> {
  late LessonCompleteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LessonCompleteModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'lessonComplete'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.requestReview();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRow>>(
      stream: _model.lessonCompleteSupabaseStream ??= SupaFlow.client
          .from("users")
          .stream(primaryKey: ['id'])
          .eqOrNull(
            'id',
            currentUserUid,
          )
          .map((list) => list.map((item) => UsersRow(item)).toList()),
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
        List<UsersRow> lessonCompleteUsersRowList = snapshot.data!;

        final lessonCompleteUsersRow = lessonCompleteUsersRowList.isNotEmpty
            ? lessonCompleteUsersRowList.first
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
              child: FutureBuilder<List<LevelsRow>>(
                future: LevelsTable().querySingleRow(
                  queryFn: (q) => q.eqOrNull(
                    'id',
                    lessonCompleteUsersRow?.currentLevelId,
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
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
                      ),
                    );
                  }
                  List<LevelsRow> stackLevelsRowList = snapshot.data!;

                  final stackLevelsRow = stackLevelsRowList.isNotEmpty
                      ? stackLevelsRowList.first
                      : null;

                  return Stack(
                    children: [
                      Lottie.asset(
                        'assets/jsons/confetti_on_transparent_background.json',
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        fit: BoxFit.contain,
                        repeat: false,
                        animate: true,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/party-popper.png',
                              width: 60.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Lesson Complete!',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 6.0, 0.0, 0.0),
                              child: Text(
                                'Great work! You\'ve completed this lesson.',
                                textAlign: TextAlign.center,
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
                                  0.0, 18.0, 0.0, 0.0),
                              child: Container(
                                width: 80.0,
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFC5DFB9),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    '+${widget.lessonXp?.toString()} XP',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFF5C9342),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 30.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    valueOrDefault<String>(
                                      stackLevelsRow?.name,
                                      'Level 4: Seeker',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    '${lessonCompleteUsersRow?.cumulativeXp?.toString()} / ${stackLevelsRow?.maxXp?.toString()} XP',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                height: 20.0,
                                child: custom_widgets.XPIndicator(
                                  width: double.infinity,
                                  height: 20.0,
                                  currentXp:
                                      lessonCompleteUsersRow!.cumulativeXp!,
                                  levelMinXp: stackLevelsRow!.minXp!,
                                  levelMaxXp: stackLevelsRow.maxXp!,
                                  selectedColor:
                                      FlutterFlowTheme.of(context).secondary,
                                  unselectedColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  size: 10.0,
                                  padding: 1.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 40.0, 0.0, 0.0),
                              child: wrapWithModel(
                                model: _model.largeBtnModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: LargeBtnWidget(
                                  text: 'Next Lesson',
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textColor: FlutterFlowTheme.of(context).info,
                                  action: () async {
                                    FFAppState().clearHomeCourseCache();

                                    context.goNamed(
                                      CourseWidget.routeName,
                                      queryParameters: {
                                        'course': serializeParam(
                                          widget.course,
                                          ParamType.SupabaseRow,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: wrapWithModel(
                                model: _model.largeBtnModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: LargeBtnWidget(
                                  text: 'Back to Home',
                                  color: Colors.transparent,
                                  textColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  action: () async {
                                    FFAppState().clearHomeCourseCache();

                                    context.goNamed(GrowWidget.routeName);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
