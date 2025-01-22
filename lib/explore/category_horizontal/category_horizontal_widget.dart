import '/backend/supabase/supabase.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'category_horizontal_model.dart';
export 'category_horizontal_model.dart';

class CategoryHorizontalWidget extends StatefulWidget {
  const CategoryHorizontalWidget({
    super.key,
    required this.category,
  });

  final CategoriesRow? category;

  @override
  State<CategoryHorizontalWidget> createState() =>
      _CategoryHorizontalWidgetState();
}

class _CategoryHorizontalWidgetState extends State<CategoryHorizontalWidget> {
  late CategoryHorizontalModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoryHorizontalModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CategoryHorizontal'});
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
                            'https://api.ievangelize.app/storage/v1/object/public/resources/cv/images/empathetic_evangelism_poster.webp',
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
                              'God Around the World',
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
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
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
                                  '1',
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
                                List<ResourcesRow> listViewResourcesRowList =
                                    snapshot.data!;

                                return ListView.separated(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    100.0,
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewResourcesRowList.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 26.0),
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewResourcesRow =
                                        listViewResourcesRowList[listViewIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (listViewResourcesRow.isVideo!) {
                                          context.pushNamed(
                                            'HorizontalVideoPlayer',
                                            queryParameters: {
                                              'title': serializeParam(
                                                listViewResourcesRow.title,
                                                ParamType.String,
                                              ),
                                              'description': serializeParam(
                                                listViewResourcesRow
                                                    .description,
                                                ParamType.String,
                                              ),
                                              'videoURL': serializeParam(
                                                listViewResourcesRow.mediaUrl,
                                                ParamType.String,
                                              ),
                                              'providerID': serializeParam(
                                                listViewResourcesRow.provider,
                                                ParamType.int,
                                              ),
                                              'shareURL': serializeParam(
                                                listViewResourcesRow.shareUrl,
                                                ParamType.String,
                                              ),
                                              'categoryTitle': serializeParam(
                                                widget.category?.title,
                                                ParamType.String,
                                              ),
                                              'categoryThumbnail':
                                                  serializeParam(
                                                widget.category?.posterUrl,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        } else {
                                          context.pushNamed(
                                            'AudioPlayer',
                                            queryParameters: {
                                              'title': serializeParam(
                                                listViewResourcesRow.title,
                                                ParamType.String,
                                              ),
                                              'thumbnailURL': serializeParam(
                                                listViewResourcesRow
                                                    .thumbnailUrl,
                                                ParamType.String,
                                              ),
                                              'subTitle': serializeParam(
                                                listViewResourcesRow.subTitle,
                                                ParamType.String,
                                              ),
                                              'audioURL': serializeParam(
                                                listViewResourcesRow.mediaUrl,
                                                ParamType.String,
                                              ),
                                              'shareURL': serializeParam(
                                                listViewResourcesRow.shareUrl,
                                                ParamType.String,
                                              ),
                                              'providerID': serializeParam(
                                                listViewResourcesRow.provider,
                                                ParamType.int,
                                              ),
                                            }.withoutNulls,
                                          );
                                        }
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
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
                                                    listViewResourcesRow
                                                        .thumbnailUrl,
                                                    'https://picsum.photos/seed/615/600',
                                                  ),
                                                  width: double.infinity,
                                                  height: 190.0,
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
                                                            listViewResourcesRow
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
                                          Text(
                                            valueOrDefault<String>(
                                              listViewResourcesRow.title,
                                              'Crazy stuff happening with Jesus Film',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
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
