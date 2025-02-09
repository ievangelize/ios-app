import '/backend/supabase/supabase.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'resource_credit_model.dart';
export 'resource_credit_model.dart';

class ResourceCreditWidget extends StatefulWidget {
  const ResourceCreditWidget({
    super.key,
    required this.provider,
  });

  final ResourceProvidersRow? provider;

  @override
  State<ResourceCreditWidget> createState() => _ResourceCreditWidgetState();
}

class _ResourceCreditWidgetState extends State<ResourceCreditWidget> {
  late ResourceCreditModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResourceCreditModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ResourceCredit'});
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              widget.provider?.name,
                              'Title',
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
                                widget.provider?.description,
                                'Description',
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
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.globe,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 18.0,
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    widget.provider?.website,
                                    'website',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 8.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'jgtk0tnl' /* More Resources */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: FutureBuilder<List<ResourcesRow>>(
                              future: ResourcesTable().queryRows(
                                queryFn: (q) => q
                                    .eqOrNull(
                                      'provider',
                                      widget.provider?.id,
                                    )
                                    .order('order'),
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
                                                listViewResourcesRow.subTitle,
                                                ParamType.String,
                                              ),
                                              'categoryThumbnail':
                                                  serializeParam(
                                                listViewResourcesRow
                                                    .thumbnailUrl,
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
                                                        .searchThumbnailUrl,
                                                    'https://picsum.photos/seed/882/600',
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
                    selectedPage: 'discover',
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
