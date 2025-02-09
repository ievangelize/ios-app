import '/backend/supabase/supabase.dart';
import '/components/explore_row_loading/explore_row_loading_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/components/searchbar_dummy/searchbar_dummy_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'explore_model.dart';
export 'explore_model.dart';

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({super.key});

  @override
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  late ExploreModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExploreModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Explore'});
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              pinned: false,
              floating: false,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(
                        'donate',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.bottomToTop,
                          ),
                        },
                      );
                    },
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2.1,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            spreadRadius: 1.0,
                          )
                        ],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).success,
                        ),
                      ),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Image.asset(
                          'assets/images/healthcare_(1).png',
                          width: 22.0,
                          height: 22.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '5dsf646v' /* Explore */,
                      ),
                      style:
                          FlutterFlowTheme.of(context).headlineLarge.override(
                                fontFamily: 'Inter',
                                fontSize: 30.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                ),
              ),
              centerTitle: false,
              elevation: 0.0,
            )
          ],
          body: Builder(
            builder: (context) {
              return SafeArea(
                top: false,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'SearchResults',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: const TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                    ),
                                  },
                                );
                              },
                              child: wrapWithModel(
                                model: _model.searchbarDummyModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const Hero(
                                  tag: 'searchbar',
                                  transitionOnUserGestures: true,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SearchbarDummyWidget(),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 24.0, 0.0, 0.0),
                              child: FutureBuilder<List<CategoriesRow>>(
                                future: FFAppState().categories(
                                  requestFn: () => CategoriesTable().queryRows(
                                    queryFn: (q) =>
                                        q.order('order', ascending: true),
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
                                  List<CategoriesRow> allCategoriesRowList =
                                      snapshot.data!;

                                  return ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      0,
                                      35.0,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: allCategoriesRowList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 38.0),
                                    itemBuilder: (context, allIndex) {
                                      final allCategoriesRow =
                                          allCategoriesRowList[allIndex];
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.6,
                                                decoration: const BoxDecoration(),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    allCategoriesRow.title,
                                                    'Evangelism Toolbox',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(),
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
                                                        if (allCategoriesRow
                                                            .isVertical!) {
                                                          context.pushNamed(
                                                            'CategoryVertical',
                                                            queryParameters: {
                                                              'category':
                                                                  serializeParam(
                                                                allCategoriesRow,
                                                                ParamType
                                                                    .SupabaseRow,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        } else {
                                                          context.pushNamed(
                                                            'CategoryHorizontal',
                                                            queryParameters: {
                                                              'category':
                                                                  serializeParam(
                                                                allCategoriesRow,
                                                                ParamType
                                                                    .SupabaseRow,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        }
                                                      },
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '5yv6f0yb' /* SEE ALL > */,
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]
                                                .addToStart(
                                                    const SizedBox(width: 16.0))
                                                .addToEnd(
                                                    const SizedBox(width: 16.0)),
                                          ),
                                          FutureBuilder<List<ResourcesRow>>(
                                            future: FFAppState().resources(
                                              uniqueQueryKey: allCategoriesRow
                                                  .id
                                                  .toString(),
                                              requestFn: () =>
                                                  ResourcesTable().queryRows(
                                                queryFn: (q) => q
                                                    .eqOrNull(
                                                      'category_id',
                                                      allCategoriesRow.id,
                                                    )
                                                    .order('order'),
                                                limit: 25,
                                              ),
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return ExploreRowLoadingWidget(
                                                  isVertical: allCategoriesRow
                                                      .isVertical,
                                                );
                                              }
                                              List<ResourcesRow>
                                                  rowResourcesRowList =
                                                  snapshot.data!;

                                              return SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: List
                                                          .generate(
                                                              rowResourcesRowList
                                                                  .length,
                                                              (rowIndex) {
                                                    final rowResourcesRow =
                                                        rowResourcesRowList[
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
                                                        if (rowResourcesRow
                                                            .isVideo!) {
                                                          if (rowResourcesRow
                                                              .isVertical!) {
                                                            context.pushNamed(
                                                              'VerticalVideoPlayer',
                                                              queryParameters: {
                                                                'videoURL':
                                                                    serializeParam(
                                                                  rowResourcesRow
                                                                      .mediaUrl,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'title':
                                                                    serializeParam(
                                                                  rowResourcesRow
                                                                      .title,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'description':
                                                                    serializeParam(
                                                                  rowResourcesRow
                                                                      .description,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'shareURL':
                                                                    serializeParam(
                                                                  rowResourcesRow
                                                                      .shareUrl,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          } else {
                                                            context.pushNamed(
                                                              'HorizontalVideoPlayer',
                                                              queryParameters: {
                                                                'title':
                                                                    serializeParam(
                                                                  rowResourcesRow
                                                                      .title,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'description':
                                                                    serializeParam(
                                                                  rowResourcesRow
                                                                      .description,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'videoURL':
                                                                    serializeParam(
                                                                  rowResourcesRow
                                                                      .mediaUrl,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'providerID':
                                                                    serializeParam(
                                                                  rowResourcesRow
                                                                      .provider,
                                                                  ParamType.int,
                                                                ),
                                                                'shareURL':
                                                                    serializeParam(
                                                                  rowResourcesRow
                                                                      .shareUrl,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'categoryTitle':
                                                                    serializeParam(
                                                                  allCategoriesRow
                                                                      .title,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'categoryThumbnail':
                                                                    serializeParam(
                                                                  allCategoriesRow
                                                                      .posterUrl,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          }
                                                        } else {
                                                          context.pushNamed(
                                                            'AudioPlayer',
                                                            queryParameters: {
                                                              'title':
                                                                  serializeParam(
                                                                rowResourcesRow
                                                                    .title,
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              'thumbnailURL':
                                                                  serializeParam(
                                                                rowResourcesRow
                                                                    .thumbnailUrl,
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              'subTitle':
                                                                  serializeParam(
                                                                rowResourcesRow
                                                                    .subTitle,
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              'audioURL':
                                                                  serializeParam(
                                                                rowResourcesRow
                                                                    .mediaUrl,
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              'shareURL':
                                                                  serializeParam(
                                                                rowResourcesRow
                                                                    .shareUrl,
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              'providerID':
                                                                  serializeParam(
                                                                rowResourcesRow
                                                                    .provider,
                                                                ParamType.int,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        }
                                                      },
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                valueOrDefault<
                                                                    double>(
                                                              rowResourcesRow
                                                                      .isVertical!
                                                                  ? 149.0
                                                                  : 266.0,
                                                              266.0,
                                                            ),
                                                            child: Stack(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      0.0, 1.0),
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    fadeInDuration:
                                                                        const Duration(
                                                                            milliseconds:
                                                                                300),
                                                                    fadeOutDuration:
                                                                        const Duration(
                                                                            milliseconds:
                                                                                300),
                                                                    imageUrl:
                                                                        valueOrDefault<
                                                                            String>(
                                                                      rowResourcesRow
                                                                          .thumbnailUrl,
                                                                      'https://picsum.photos/seed/136/600',
                                                                    ),
                                                                    width: valueOrDefault<
                                                                        double>(
                                                                      rowResourcesRow
                                                                              .isVertical!
                                                                          ? 149.0
                                                                          : 266.0,
                                                                      266.0,
                                                                    ),
                                                                    height: valueOrDefault<
                                                                        double>(
                                                                      rowResourcesRow
                                                                              .isVertical!
                                                                          ? 240.0
                                                                          : 150.0,
                                                                      150.0,
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            18.0,
                                                                        height:
                                                                            18.0,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              Color(0x9A000000),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .play_arrow,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).info,
                                                                          size:
                                                                              11.0,
                                                                        ),
                                                                      ),
                                                                      FFButtonWidget(
                                                                        onPressed:
                                                                            () {
                                                                          print(
                                                                              'Button pressed ...');
                                                                        },
                                                                        text: rowResourcesRow
                                                                            .duration!,
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              36.0,
                                                                          height:
                                                                              18.0,
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              1.0,
                                                                              0.0),
                                                                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          color:
                                                                              const Color(0x9A000000),
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: Colors.white,
                                                                                fontSize: 1.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w300,
                                                                              ),
                                                                          elevation:
                                                                              0.0,
                                                                          borderRadius:
                                                                              BorderRadius.circular(50.0),
                                                                        ),
                                                                        showLoadingIndicator:
                                                                            false,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        8.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                rowResourcesRow
                                                                    .subTitle,
                                                                'Sub title',
                                                              ).maybeHandleOverflow(
                                                                maxChars:
                                                                    valueOrDefault<
                                                                        int>(
                                                                  rowResourcesRow
                                                                          .isVertical!
                                                                      ? 16
                                                                      : 31,
                                                                  31,
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              rowResourcesRow
                                                                  .title,
                                                              'Three: Jesus is th answer to all',
                                                            ).maybeHandleOverflow(
                                                              maxChars:
                                                                  valueOrDefault<
                                                                      int>(
                                                                rowResourcesRow
                                                                        .isVertical!
                                                                    ? 15
                                                                    : 31,
                                                                31,
                                                              ),
                                                              replacement: '…',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  })
                                                      .divide(
                                                          const SizedBox(width: 16.0))
                                                      .addToStart(
                                                          const SizedBox(width: 16.0))
                                                      .addToEnd(const SizedBox(
                                                          width: 16.0)),
                                                ),
                                              );
                                            },
                                          ),
                                        ].divide(const SizedBox(height: 12.0)),
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
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: wrapWithModel(
                        model: _model.navBarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: const NavBarWidget(
                          selectedPage: 'explore',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
