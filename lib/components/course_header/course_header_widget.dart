import '/components/courses_list/courses_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'course_header_model.dart';
export 'course_header_model.dart';

class CourseHeaderWidget extends StatefulWidget {
  const CourseHeaderWidget({
    super.key,
    this.name,
    this.title,
    this.totalLessons,
    this.colorCode,
    this.id,
  });

  final String? name;
  final String? title;
  final int? totalLessons;
  final String? colorCode;
  final String? id;

  @override
  State<CourseHeaderWidget> createState() => _CourseHeaderWidgetState();
}

class _CourseHeaderWidgetState extends State<CourseHeaderWidget> {
  late CourseHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CourseHeaderModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: CoursesListWidget(),
              );
            },
          ).then((value) => safeSetState(() {}));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorFromCssString(
              widget.colorCode!,
              defaultColor: Color(0xFF864AF9),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                color: Color(0x1A000000),
                offset: Offset(
                  0.0,
                  2.0,
                ),
                spreadRadius: 0.0,
              )
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name!,
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0xCBFFFFFF),
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            widget.title!,
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                  lineHeight: 1.2,
                                ),
                          ),
                        ].divide(SizedBox(height: 3.0)),
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor: Color(0x24FFFFFF),
                      icon: FaIcon(
                        FontAwesomeIcons.brain,
                        color: FlutterFlowTheme.of(context).info,
                        size: 20.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ].divide(SizedBox(width: 2.0)),
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
                                'course_id': widget.id,
                              },
                              r'''$.course_id''',
                            ))
                        .toList()
                        .isNotEmpty
                    ? true
                    : false)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                            'course_id': widget.id,
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
                                            'course_id': widget.id,
                                          },
                                          r'''$.course_id''',
                                        ))
                                    .toList()
                                    .firstOrNull,
                                r'''$.total_lessons''',
                              )),
                          lineHeight: 8.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).info,
                          backgroundColor: Color(0x2DFFFFFF),
                          barRadius: Radius.circular(4.0),
                          padding: EdgeInsets.zero,
                        ),
                      ),
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
                                      'course_id': widget.id,
                                    },
                                    r'''$.course_id''',
                                  ))
                              .toList()
                              .firstOrNull,
                          r'''$.lessons_completed''',
                        ).toString()} / ${getJsonField(
                          FFAppState()
                              .exploreUcpIdsJson
                              .where((e) =>
                                  getJsonField(
                                    e,
                                    r'''$.course_id''',
                                  ) ==
                                  getJsonField(
                                    <String, dynamic>{
                                      'course_id': widget.id,
                                    },
                                    r'''$.course_id''',
                                  ))
                              .toList()
                              .firstOrNull,
                          r'''$.total_lessons''',
                        ).toString()}',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
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
                                'course_id': widget.id,
                              },
                              r'''$.course_id''',
                            ))
                        .toList()
                        .isNotEmpty
                    ? false
                    : true)
                  Text(
                    '${widget.totalLessons?.toString()} lessons',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
              ].divide(SizedBox(height: 4.0)),
            ),
          ),
        ),
      ),
    );
  }
}
