import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/app_bar_loading/app_bar_loading_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/components/pathway_item/pathway_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pathway_model.dart';
export 'pathway_model.dart';

class PathwayWidget extends StatefulWidget {
  const PathwayWidget({
    super.key,
    this.scrollToCourseId,
  });

  final String? scrollToCourseId;

  static String routeName = 'pathway';
  static String routePath = 'pathway';

  @override
  State<PathwayWidget> createState() => _PathwayWidgetState();
}

class _PathwayWidgetState extends State<PathwayWidget> {
  late PathwayModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PathwayModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'pathway'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().exploreUcpIdsJson.isNotEmpty) {
        if (widget.scrollToCourseId != null &&
            widget.scrollToCourseId != '') {
          await actions.scrollToIndex(
            widget.scrollToCourseId!,
          );
        } else {
          await actions.scrollToIndex(
            getJsonField(
              FFAppState().exploreUcpIdsJson.lastOrNull,
              r'''$.course_id''',
            ).toString(),
          );
        }
      } else {
        _model.ucp = await UserCourseProgressTable().queryRows(
          queryFn: (q) => q
              .eqOrNull(
                'user_id',
                currentUserUid,
              )
              .order('last_engaged_at', ascending: true),
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
        await actions.scrollToIndex(
          _model.ucp!.lastOrNull!.courseId!,
        );
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
        List<UsersRow> pathwayUsersRowList = snapshot.data!;

        final pathwayUsersRow =
            pathwayUsersRowList.isNotEmpty ? pathwayUsersRowList.first : null;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<List<LevelsRow>>(
                            future: LevelsTable().querySingleRow(
                              queryFn: (q) => q.eqOrNull(
                                'id',
                                pathwayUsersRow?.currentLevelId,
                              ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return AppBarLoadingWidget();
                              }
                              List<LevelsRow> appBarLevelsRowList =
                                  snapshot.data!;

                              final appBarLevelsRow =
                                  appBarLevelsRowList.isNotEmpty
                                      ? appBarLevelsRowList.first
                                      : null;

                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await actions.scrollToIndex(
                                                    '5fd753ca-41aa-4c2d-a62d-140c0d1dcd9c',
                                                  );
                                                },
                                                child: Text(
                                                  'Grow',
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
                                                        fontSize: 30.0,
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
                                            ],
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 8.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      DonateWidget.routeName,
                                                      extra: <String, dynamic>{
                                                        '__transition_info__':
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .bottomToTop,
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
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .solidHeart,
                                                      color: Color(0xFFF13A28),
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                  ProfileWidget.routeName);
                                            },
                                            child: Container(
                                              width: 38.0,
                                              height: 38.0,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: CachedNetworkImage(
                                                fadeInDuration:
                                                    Duration(milliseconds: 500),
                                                fadeOutDuration:
                                                    Duration(milliseconds: 500),
                                                imageUrl:
                                                    'https://api.ievangelize.app/storage/v1/object/public/users/profile_pics/1768771110733123.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 18.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              valueOrDefault<String>(
                                                appBarLevelsRow?.name,
                                                'Level 15 • Spirit-Led Messenger',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                                        fontSize: 14.0,
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
                                              '${pathwayUsersRow?.cumulativeXp?.toString()} / ${appBarLevelsRow?.maxXp?.toString()} XP',
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                                        fontSize: 14.0,
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
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 20.0,
                                        child: custom_widgets.XPIndicator(
                                          width: double.infinity,
                                          height: 20.0,
                                          currentXp:
                                              pathwayUsersRow!.cumulativeXp!,
                                          levelMinXp: appBarLevelsRow!.minXp!,
                                          levelMaxXp: appBarLevelsRow.maxXp!,
                                          selectedColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                          unselectedColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          size: 10.0,
                                          padding: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Divider(
                            height: 1.0,
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).accent1,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: custom_widgets.ScrollableWidget(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        children: () => PathwayItemWidget(),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: wrapWithModel(
                    model: _model.navBarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: NavBarWidget(
                      selectedPage: 'pathway',
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
