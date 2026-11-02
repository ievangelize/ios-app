import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/course_locked/course_locked_widget.dart';
import '/components/explore_loading/explore_loading_widget.dart';
import '/components/explore_row_loading/explore_row_loading_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'grow_model.dart';
export 'grow_model.dart';

class GrowWidget extends StatefulWidget {
  const GrowWidget({super.key});

  static String routeName = 'grow';
  static String routePath = 'explore';

  @override
  State<GrowWidget> createState() => _GrowWidgetState();
}

class _GrowWidgetState extends State<GrowWidget> {
  late GrowModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GrowModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'grow'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!(FFAppState().exploreUcpIdsJson.isNotEmpty)) {
        _model.ucp = await UserCourseProgressTable().queryRows(
          queryFn: (q) => q.eqOrNull(
            'user_id',
            currentUserUid,
          ),
        );
        for (int loop1Index = 0;
            loop1Index < _model.ucp!.length;
            loop1Index++) {
          final currentLoop1Item = _model.ucp![loop1Index];
          FFAppState().addToExploreUcpIdsJson(<String, dynamic>{
            'course_id': currentLoop1Item.courseId,
            'lessons_completed': currentLoop1Item.lessonsCompleted,
            'total_lessons': currentLoop1Item.totalLessons,
          });
          safeSetState(() {});
        }
      }
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<UsersRow>>(
      future: UsersTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'id',
          currentUserUid,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: ExploreLoadingWidget(),
          );
        }
        List<UsersRow> growUsersRowList = snapshot.data!;

        final growUsersRow =
            growUsersRowList.isNotEmpty ? growUsersRowList.first : null;

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
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Grow',
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
                                            fontSize: 30.0,
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
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        DonateWidget.routeName,
                                        extra: <String, dynamic>{
                                          '__transition_info__': TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.bottomToTop,
                                          ),
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 34.0,
                                      height: 34.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEE2E1),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: FaIcon(
                                        FaIconData(const IconData(
                                            /* solidHeart */ 0xf004,
                                            fontFamily: 'FontAwesomeSolid',
                                            fontPackage:
                                                'font_awesome_flutter')),
                                        color: Color(0xFFF13A28),
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
                                child: FutureBuilder<List<TiersRow>>(
                                  future: FFAppState().tiers(
                                    requestFn: () => TiersTable().queryRows(
                                      queryFn: (q) => q.order('sort_order',
                                          ascending: true),
                                    ),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return ExploreRowLoadingWidget(
                                        isVertical: false,
                                      );
                                    }
                                    List<TiersRow> allTiersRowList =
                                        snapshot.data!;

                                    return ListView.separated(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        35.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: allTiersRowList.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 30.0),
                                      itemBuilder: (context, allIndex) {
                                        final allTiersRow =
                                            allTiersRowList[allIndex];
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    allTiersRow.name,
                                                    'Tier 4: Evangelism and the Holy Spirit',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 18.0,
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
                                              ]
                                                  .addToStart(
                                                      SizedBox(width: 16.0))
                                                  .addToEnd(
                                                      SizedBox(width: 16.0)),
                                            ),
                                            FutureBuilder<List<CoursesRow>>(
                                              future: FFAppState().courses(
                                                uniqueQueryKey: allTiersRow.id,
                                                requestFn: () =>
                                                    CoursesTable().queryRows(
                                                  queryFn: (q) => q
                                                      .eqOrNull(
                                                        'tier_id',
                                                        allTiersRow.id,
                                                      )
                                                      .order('sort_order',
                                                          ascending: true),
                                                ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return ExploreRowLoadingWidget(
                                                    isVertical: false,
                                                  );
                                                }
                                                List<CoursesRow>
                                                    rowCoursesRowList =
                                                    snapshot.data!;

                                                return SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: List.generate(
                                                            rowCoursesRowList
                                                                .length,
                                                            (rowIndex) {
                                                      final rowCoursesRow =
                                                          rowCoursesRowList[
                                                              rowIndex];
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          if (growUsersRow
                                                                  .cumulativeXp! >=
                                                              allTiersRow
                                                                  .minXp!) {
                                                            HapticFeedback
                                                                .lightImpact();

                                                            context.pushNamed(
                                                              CourseWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'course':
                                                                    serializeParam(
                                                                  rowCoursesRow,
                                                                  ParamType
                                                                      .SupabaseRow,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          } else {
                                                            await Future
                                                                .delayed(
                                                              Duration(
                                                                milliseconds:
                                                                    100,
                                                              ),
                                                            );
                                                            showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        CourseLockedWidget(),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));

                                                            for (int loop1Index =
                                                                    0;
                                                                loop1Index <
                                                                    _model
                                                                        .haptics
                                                                        .length;
                                                                loop1Index++) {
                                                              final currentLoop1Item =
                                                                  _model.haptics[
                                                                      loop1Index];
                                                              HapticFeedback
                                                                  .mediumImpact();
                                                              await Future
                                                                  .delayed(
                                                                Duration(
                                                                  milliseconds:
                                                                      currentLoop1Item,
                                                                ),
                                                              );
                                                            }
                                                          }
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Hero(
                                                              tag:
                                                                  valueOrDefault<
                                                                      String>(
                                                                rowCoursesRow
                                                                    .thumbnailUrl,
                                                                'https://api.ievangelize.app/storage/v1/object/public/resources/ievangelize/course-thumbnails/Creative%20Strategies%20for%20Evangelism-min.png' +
                                                                    '$rowIndex',
                                                              ),
                                                              transitionOnUserGestures:
                                                                  true,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  fadeInDuration:
                                                                      Duration(
                                                                          milliseconds:
                                                                              200),
                                                                  fadeOutDuration:
                                                                      Duration(
                                                                          milliseconds:
                                                                              200),
                                                                  imageUrl:
                                                                      valueOrDefault<
                                                                          String>(
                                                                    rowCoursesRow
                                                                        .thumbnailUrl,
                                                                    'https://api.ievangelize.app/storage/v1/object/public/resources/ievangelize/course-thumbnails/Creative%20Strategies%20for%20Evangelism-min.png',
                                                                  ),
                                                                  width: 284.0,
                                                                  height: 160.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 284.0,
                                                              height: 160.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0x4D000000),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        12.0,
                                                                        12.0,
                                                                        8.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          6.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          rowCoursesRow
                                                                              .title,
                                                                          'The Miraculous Signs of the Evangelist',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).info,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              lineHeight: 1.2,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    if (FFAppState()
                                                                            .exploreUcpIdsJson
                                                                            .where((e) =>
                                                                                getJsonField(
                                                                                  e,
                                                                                  r'''$.course_id''',
                                                                                ) ==
                                                                                getJsonField(
                                                                                  <String, dynamic>{
                                                                                    'course_id': rowCoursesRow.id,
                                                                                  },
                                                                                  r'''$.course_id''',
                                                                                ))
                                                                            .toList()
                                                                            .isNotEmpty
                                                                        ? true
                                                                        : false)
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Text(
                                                                            '${getJsonField(
                                                                              FFAppState()
                                                                                  .exploreUcpIdsJson
                                                                                  .where((e) =>
                                                                                      getJsonField(
                                                                                        e,
                                                                                        r'''$.course_id''',
                                                                                      ) ==
                                                                                      getJsonField(
                                                                                        <String, dynamic>{
                                                                                          'course_id': rowCoursesRow.id,
                                                                                        },
                                                                                        r'''$.course_id''',
                                                                                      ))
                                                                                  .toList()
                                                                                  .firstOrNull,
                                                                              r'''$.lessons_completed''',
                                                                            ).toString()} of ${getJsonField(
                                                                              FFAppState()
                                                                                  .exploreUcpIdsJson
                                                                                  .where((e) =>
                                                                                      getJsonField(
                                                                                        e,
                                                                                        r'''$.course_id''',
                                                                                      ) ==
                                                                                      getJsonField(
                                                                                        <String, dynamic>{
                                                                                          'course_id': rowCoursesRow.id,
                                                                                        },
                                                                                        r'''$.course_id''',
                                                                                      ))
                                                                                  .toList()
                                                                                  .firstOrNull,
                                                                              r'''$.total_lessons''',
                                                                            ).toString()}',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).info,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Expanded(
                                                                                child: LinearPercentIndicator(
                                                                                  percent: functions.coursePercantage(
                                                                                      getJsonField(
                                                                                        FFAppState()
                                                                                            .exploreUcpIdsJson
                                                                                            .where((e) =>
                                                                                                getJsonField(
                                                                                                  e,
                                                                                                  r'''$.course_id''',
                                                                                                ) ==
                                                                                                getJsonField(
                                                                                                  <String, dynamic>{
                                                                                                    'course_id': rowCoursesRow.id,
                                                                                                  },
                                                                                                  r'''$.course_id''',
                                                                                                ))
                                                                                            .toList()
                                                                                            .firstOrNull,
                                                                                        r'''$.lessons_completed''',
                                                                                      ),
                                                                                      getJsonField(
                                                                                        FFAppState()
                                                                                            .exploreUcpIdsJson
                                                                                            .where((e) =>
                                                                                                getJsonField(
                                                                                                  e,
                                                                                                  r'''$.course_id''',
                                                                                                ) ==
                                                                                                getJsonField(
                                                                                                  <String, dynamic>{
                                                                                                    'course_id': rowCoursesRow.id,
                                                                                                  },
                                                                                                  r'''$.course_id''',
                                                                                                ))
                                                                                            .toList()
                                                                                            .firstOrNull,
                                                                                        r'''$.total_lessons''',
                                                                                      )),
                                                                                  lineHeight: 6.0,
                                                                                  animation: true,
                                                                                  animateFromLastPercent: true,
                                                                                  progressColor: FlutterFlowTheme.of(context).info,
                                                                                  backgroundColor: Color(0x2DFFFFFF),
                                                                                  barRadius: Radius.circular(12.0),
                                                                                  padding: EdgeInsets.zero,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ].divide(SizedBox(height: 3.0)),
                                                                      ),
                                                                    if (FFAppState()
                                                                            .exploreUcpIdsJson
                                                                            .where((e) =>
                                                                                getJsonField(
                                                                                  e,
                                                                                  r'''$.course_id''',
                                                                                ) ==
                                                                                getJsonField(
                                                                                  <String, dynamic>{
                                                                                    'course_id': rowCoursesRow.id,
                                                                                  },
                                                                                  r'''$.course_id''',
                                                                                ))
                                                                            .toList()
                                                                            .isNotEmpty
                                                                        ? false
                                                                        : true)
                                                                      Text(
                                                                        '${rowCoursesRow.totalLessons?.toString()} lessons',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).info,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            if (growUsersRow!
                                                                        .cumulativeXp! >=
                                                                    allTiersRow
                                                                        .minXp!
                                                                ? false
                                                                : true)
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                child:
                                                                    BackdropFilter(
                                                                  filter:
                                                                      ImageFilter
                                                                          .blur(
                                                                    sigmaX: 5.0,
                                                                    sigmaY: 7.0,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        284.0,
                                                                    height:
                                                                        160.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x80000000),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          FaIcon(
                                                                        FaIconData(const IconData(
                                                                            /* lock */ 0xf023,
                                                                            fontFamily:
                                                                                'FontAwesomeSolid',
                                                                            fontPackage:
                                                                                'font_awesome_flutter')),
                                                                        color: Color(
                                                                            0xCBFFFFFF),
                                                                        size:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      );
                                                    })
                                                        .divide(SizedBox(
                                                            width: 16.0))
                                                        .addToStart(SizedBox(
                                                            width: 16.0))
                                                        .addToEnd(SizedBox(
                                                            width: 16.0)),
                                                  ),
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 8.0)),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              if (!(isWeb
                                  ? MediaQuery.viewInsetsOf(context).bottom > 0
                                  : _isKeyboardVisible))
                                Container(
                                  width: double.infinity,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
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
