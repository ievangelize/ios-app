import '/backend/supabase/supabase.dart';
import '/components/explore_row_loading/explore_row_loading_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'courses_list_model.dart';
export 'courses_list_model.dart';

class CoursesListWidget extends StatefulWidget {
  const CoursesListWidget({super.key});

  @override
  State<CoursesListWidget> createState() => _CoursesListWidgetState();
}

class _CoursesListWidgetState extends State<CoursesListWidget> {
  late CoursesListModel _model;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoursesListModel());

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
    _model.maybeDispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 56.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.close_sharp,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 25.0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 55.0, 0.0),
                      child: Text(
                        'Courses',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: FutureBuilder<List<TiersRow>>(
                        future: FFAppState().tiers(
                          requestFn: () => TiersTable().queryRows(
                            queryFn: (q) =>
                                q.order('sort_order', ascending: true),
                          ),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return ExploreRowLoadingWidget(
                              isVertical: false,
                            );
                          }
                          List<TiersRow> allTiersRowList = snapshot.data!;

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
                            separatorBuilder: (_, __) => SizedBox(height: 30.0),
                            itemBuilder: (context, allIndex) {
                              final allTiersRow = allTiersRowList[allIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          allTiersRow.name,
                                          'Tier 4: Evangelism and the Holy Spirit',
                                        ),
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
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ]
                                        .addToStart(SizedBox(width: 16.0))
                                        .addToEnd(SizedBox(width: 16.0)),
                                  ),
                                  FutureBuilder<List<CoursesRow>>(
                                    future: FFAppState().courses(
                                      uniqueQueryKey: allTiersRow.id,
                                      requestFn: () => CoursesTable().queryRows(
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
                                      List<CoursesRow> rowCoursesRowList =
                                          snapshot.data!;

                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: List.generate(
                                                  rowCoursesRowList.length,
                                                  (rowIndex) {
                                            final rowCoursesRow =
                                                rowCoursesRowList[rowIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                HapticFeedback.lightImpact();
                                                Navigator.pop(context);
                                                await actions.scrollToIndex(
                                                  rowCoursesRow.id!,
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 4.0,
                                                                0.0, 0.0),
                                                    child: Container(
                                                      height: 120.0,
                                                      child: Stack(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 1.0),
                                                        children: [
                                                          Container(
                                                            width: 284.0,
                                                            height: 23.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  colorFromCssString(
                                                                allTiersRow
                                                                    .colorCode!,
                                                                defaultColor:
                                                                    Colors
                                                                        .black,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 284.0,
                                                            height: 23.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0x53000000),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 284.0,
                                                    height: 120.0,
                                                    decoration: BoxDecoration(
                                                      color: colorFromCssString(
                                                        allTiersRow.colorCode!,
                                                        defaultColor:
                                                            Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          8.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        rowCoursesRow
                                                                            .title,
                                                                        'The Miraculous Signs of the Evangelist',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            fontSize:
                                                                                18.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            lineHeight:
                                                                                1.2,
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
                                                                      ).toString()} complete',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                      ? false
                                                                      : true)
                                                                    Text(
                                                                      '${rowCoursesRow.totalLessons?.toString()} lessons',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          VerticalDivider(
                                                            thickness: 2.5,
                                                            color: Color(
                                                                0x53000000),
                                                          ),
                                                          FaIcon(
                                                            FaIconData(const IconData(
                                                                /* brain */ 0xf5dc,
                                                                fontFamily:
                                                                    'FontAwesomeSolid',
                                                                fontPackage:
                                                                    'font_awesome_flutter')),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            size: 32.0,
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 12.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                              .divide(SizedBox(width: 16.0))
                                              .addToStart(SizedBox(width: 16.0))
                                              .addToEnd(SizedBox(width: 16.0)),
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
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ].addToStart(SizedBox(height: 24.0)),
      ),
    );
  }
}
