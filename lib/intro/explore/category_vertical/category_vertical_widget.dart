import '/backend/supabase/supabase.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'category_vertical_model.dart';
export 'category_vertical_model.dart';

class CategoryVerticalWidget extends StatefulWidget {
  const CategoryVerticalWidget({
    super.key,
    required this.category,
  });

  final CategoriesRow? category;

  @override
  State<CategoryVerticalWidget> createState() => _CategoryVerticalWidgetState();
}

class _CategoryVerticalWidgetState extends State<CategoryVerticalWidget> {
  late CategoryVerticalModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoryVerticalModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CategoryVertical'});
  }

  @override
  void dispose() {
    _model.dispose();

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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
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
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: CachedNetworkImage(
                          fadeInDuration: const Duration(milliseconds: 300),
                          fadeOutDuration: const Duration(milliseconds: 300),
                          imageUrl: valueOrDefault<String>(
                            widget.category?.posterUrl,
                            'https://movecloser.org/wp-content/uploads/2019/12/gospel.jpg',
                          ),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              widget.category?.title,
                              'Category title',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.category?.description,
                                'Category description',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 24.0, 0.0, 0.0),
                            child: FutureBuilder<List<ResourcesRow>>(
                              future: FFAppState().resources(
                                uniqueQueryKey: valueOrDefault<String>(
                                  widget.category?.id.toString(),
                                  'id',
                                ),
                                requestFn: () => ResourcesTable().queryRows(
                                  queryFn: (q) => q
                                      .eqOrNull(
                                        'category_id',
                                        widget.category?.id,
                                      )
                                      .order('order'),
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
                                List<ResourcesRow> gridViewResourcesRowList =
                                    snapshot.data!;

                                return GridView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    230.0,
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 0.5,
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: gridViewResourcesRowList.length,
                                  itemBuilder: (context, gridViewIndex) {
                                    final gridViewResourcesRow =
                                        gridViewResourcesRowList[gridViewIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'VerticalVideoPlayer',
                                          queryParameters: {
                                            'videoURL': serializeParam(
                                              gridViewResourcesRow.mediaUrl,
                                              ParamType.String,
                                            ),
                                            'title': serializeParam(
                                              gridViewResourcesRow.title,
                                              ParamType.String,
                                            ),
                                            'description': serializeParam(
                                              gridViewResourcesRow.description,
                                              ParamType.String,
                                            ),
                                            'shareURL': serializeParam(
                                              gridViewResourcesRow.shareUrl,
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType: PageTransitionType
                                                  .bottomToTop,
                                            ),
                                          },
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            alignment:
                                                const AlignmentDirectional(0.0, 1.0),
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: CachedNetworkImage(
                                                  fadeInDuration: const Duration(
                                                      milliseconds: 300),
                                                  fadeOutDuration: const Duration(
                                                      milliseconds: 300),
                                                  imageUrl:
                                                      valueOrDefault<String>(
                                                    gridViewResourcesRow
                                                        .thumbnailUrl,
                                                    'https://picsum.photos/seed/877/600',
                                                  ),
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height: 260.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Align(
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 20.0,
                                                        height: 20.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0x9A000000),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.play_arrow,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .info,
                                                          size: 12.0,
                                                        ),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () {
                                                          print(
                                                              'Button pressed ...');
                                                        },
                                                        text:
                                                            gridViewResourcesRow
                                                                .duration!,
                                                        options:
                                                            FFButtonOptions(
                                                          width: 40.0,
                                                          height: 20.0,
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
                                                                    fontSize:
                                                                        2.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        showLoadingIndicator:
                                                            false,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                valueOrDefault<String>(
                                                  gridViewResourcesRow.subTitle,
                                                  'iEvangelize',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                              Text(
                                                valueOrDefault<String>(
                                                  gridViewResourcesRow.title,
                                                  'Should every Christain',
                                                ).maybeHandleOverflow(
                                                  maxChars: 21,
                                                  replacement: '…',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ].divide(const SizedBox(height: 8.0)),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
