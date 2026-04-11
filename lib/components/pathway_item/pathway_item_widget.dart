import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/course_header/course_header_widget.dart';
import '/components/course_path/course_path_widget.dart';
import '/components/course_path_loading/course_path_loading_widget.dart';
import '/components/pathway_item_loading/pathway_item_loading_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import 'pathway_item_model.dart';
export 'pathway_item_model.dart';

class PathwayItemWidget extends StatefulWidget {
  const PathwayItemWidget({super.key});

  @override
  State<PathwayItemWidget> createState() => _PathwayItemWidgetState();
}

class _PathwayItemWidgetState extends State<PathwayItemWidget> {
  late PathwayItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PathwayItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
      child: FutureBuilder<List<CoursesRow>>(
        future: FFAppState().courses(
          requestFn: () => CoursesTable().queryRows(
            queryFn: (q) => q.order('global_sort_order', ascending: true),
          ),
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return PathwayItemLoadingWidget();
          }
          List<CoursesRow> columnCoursesRowList = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                  List.generate(columnCoursesRowList.length, (columnIndex) {
                final columnCoursesRow = columnCoursesRowList[columnIndex];
                return FutureBuilder<List<TiersRow>>(
                  future: FFAppState().tiers(
                    uniqueQueryKey: columnCoursesRow.id,
                    requestFn: () => TiersTable().querySingleRow(
                      queryFn: (q) => q.eqOrNull(
                        'id',
                        columnCoursesRow.tierId,
                      ),
                    ),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return PathwayItemLoadingWidget();
                    }
                    List<TiersRow> stickyHeaderTiersRowList = snapshot.data!;

                    final stickyHeaderTiersRow =
                        stickyHeaderTiersRowList.isNotEmpty
                            ? stickyHeaderTiersRowList.first
                            : null;

                    return StickyHeader(
                      overlapHeaders: false,
                      header: custom_widgets.ScrollTargetWidget(
                        width: double.infinity,
                        height: 100.0,
                        id: columnCoursesRow.id,
                        child: () => CourseHeaderWidget(
                          name: valueOrDefault<String>(
                            stickyHeaderTiersRow?.name,
                            'TIER 1: BASICS OF EVANGELISM',
                          ),
                          title: valueOrDefault<String>(
                            columnCoursesRow.title,
                            'Apologetics for Everyday',
                          ),
                          id: columnCoursesRow.id,
                          totalLessons: columnCoursesRow.totalLessons,
                          colorCode: stickyHeaderTiersRow?.colorCode,
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FutureBuilder<List<UserLessonProgressRow>>(
                            future: FFAppState().ulps(
                              uniqueQueryKey: columnCoursesRow.id,
                              requestFn: () =>
                                  UserLessonProgressTable().queryRows(
                                queryFn: (q) => q
                                    .eqOrNull(
                                      'course_id',
                                      columnCoursesRow.id,
                                    )
                                    .eqOrNull(
                                      'user_id',
                                      currentUserUid,
                                    )
                                    .order('created_at', ascending: true),
                              ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return CoursePathLoadingWidget();
                              }
                              List<UserLessonProgressRow>
                                  containerUserLessonProgressRowList =
                                  snapshot.data!;

                              return Container(
                                decoration: BoxDecoration(),
                                child: FutureBuilder<List<CourseLessonsRow>>(
                                  future: FFAppState().lessons(
                                    uniqueQueryKey: columnCoursesRow.id,
                                    requestFn: () =>
                                        CourseLessonsTable().queryRows(
                                      queryFn: (q) => q
                                          .eqOrNull(
                                            'course_id',
                                            columnCoursesRow.id,
                                          )
                                          .order('sort_order', ascending: true),
                                    ),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return CoursePathLoadingWidget();
                                    }
                                    List<CourseLessonsRow>
                                        coursePathCourseLessonsRowList =
                                        snapshot.data!;

                                    return CoursePathWidget(
                                      key: Key(
                                          'Keyg2i_${columnIndex}_of_${columnCoursesRowList.length}'),
                                      course: columnCoursesRow,
                                      colorCode:
                                          stickyHeaderTiersRow!.colorCode!,
                                      lessons: coursePathCourseLessonsRowList,
                                      ulps: containerUserLessonProgressRowList,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              })
                      .addToStart(SizedBox(height: 12.0))
                      .addToEnd(SizedBox(height: 100.0)),
            ),
          );
        },
      ),
    );
  }
}
