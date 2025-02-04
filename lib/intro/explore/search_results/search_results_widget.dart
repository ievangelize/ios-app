import '/backend/api_requests/api_calls.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/components/searchbar/searchbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'search_results_model.dart';
export 'search_results_model.dart';

class SearchResultsWidget extends StatefulWidget {
  const SearchResultsWidget({
    super.key,
    this.initialSearch,
    this.initialChoiceChip,
  });

  final String? initialSearch;
  final String? initialChoiceChip;

  @override
  State<SearchResultsWidget> createState() => _SearchResultsWidgetState();
}

class _SearchResultsWidgetState extends State<SearchResultsWidget> {
  late SearchResultsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchResultsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'SearchResults'});
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.goNamed(
                'Explore',
                extra: <String, dynamic>{
                  kTransitionInfoKey: const TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                  ),
                },
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
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
                      wrapWithModel(
                        model: _model.searchbarModel,
                        updateCallback: () => safeSetState(() {}),
                        updateOnChange: true,
                        child: Hero(
                          tag: 'searchbar',
                          transitionOnUserGestures: true,
                          child: Material(
                            color: Colors.transparent,
                            child: SearchbarWidget(
                              initialKeyword: widget.initialSearch,
                              initialChip: widget.initialChoiceChip,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: SearchResourcesCall.call(
                            supabaseKey: FFAppState().SupabaseKey,
                            keyword:
                                _model.searchbarModel.searchTextController.text,
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
                            final listViewSearchResourcesResponse =
                                snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final resources =
                                    listViewSearchResourcesResponse.jsonBody
                                        .toList();

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: resources.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 16.0),
                                  itemBuilder: (context, resourcesIndex) {
                                    final resourcesItem =
                                        resources[resourcesIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (getJsonField(
                                          resourcesItem,
                                          r'''$.is_vertical''',
                                        )) {
                                          context.pushNamed(
                                            'VerticalVideoPlayer',
                                            queryParameters: {
                                              'videoURL': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.media_url''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'title': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.title''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'description': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.sub_title''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'shareURL': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.share_url''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  const TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType
                                                        .bottomToTop,
                                              ),
                                            },
                                          );
                                        } else {
                                          context.pushNamed(
                                            'HorizontalVideoPlayer',
                                            queryParameters: {
                                              'title': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.title''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'description': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.description''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'videoURL': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.media_url''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'providerID': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.provider''',
                                                ),
                                                ParamType.int,
                                              ),
                                              'shareURL': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.share_url''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'categoryTitle': serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.sub_title''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'categoryThumbnail':
                                                  serializeParam(
                                                getJsonField(
                                                  resourcesItem,
                                                  r'''$.thumbnail_url''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        }
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 150.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                  getJsonField(
                                                    resourcesItem,
                                                    r'''$.search_thumbnail_url''',
                                                  ).toString(),
                                                ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, 1.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 12.0, 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 18.0,
                                                      height: 18.0,
                                                      decoration: const BoxDecoration(
                                                        color:
                                                            Color(0x9A000000),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Icons.play_arrow,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        size: 11.0,
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text: getJsonField(
                                                        resourcesItem,
                                                        r'''$.duration''',
                                                      ).toString(),
                                                      options: FFButtonOptions(
                                                        width: 36.0,
                                                        height: 18.0,
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    1.0,
                                                                    0.0),
                                                        iconPadding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            const Color(0x9A000000),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 1.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                        elevation: 0.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                      ),
                                                      showLoadingIndicator:
                                                          false,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getJsonField(
                                                    resourcesItem,
                                                    r'''$.title''',
                                                  )
                                                      .toString()
                                                      .maybeHandleOverflow(
                                                        maxChars: 54,
                                                        replacement: '…',
                                                      ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Text(
                                                    getJsonField(
                                                      resourcesItem,
                                                      r'''$.sub_title''',
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]
                                            .divide(const SizedBox(width: 12.0))
                                            .addToStart(const SizedBox(width: 16.0))
                                            .addToEnd(const SizedBox(width: 16.0)),
                                      ),
                                    );
                                  },
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
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
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
        ),
      ),
    );
  }
}
