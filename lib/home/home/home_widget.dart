import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/home_video_loading/home_video_loading_widget.dart';
import '/components/mission/mission_widget.dart';
import '/components/missions_loading/missions_loading_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/components/quote_loading/quote_loading_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'home'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UsersRow>>(
      future: FFAppState().profile(
        requestFn: () => UsersTable().querySingleRow(
          queryFn: (q) => q.eqOrNull(
            'id',
            currentUserUid,
          ),
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
        List<UsersRow> homeUsersRowList = snapshot.data!;

        final homeUsersRow =
            homeUsersRowList.isNotEmpty ? homeUsersRowList.first : null;

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
              leading: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('More');
                      },
                      child: Container(
                        width: 38.0,
                        height: 38.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeOutDuration: const Duration(milliseconds: 500),
                          imageUrl: valueOrDefault<String>(
                            homeUsersRow?.profileAdded == true
                                ? homeUsersRow?.profileUrl
                                : 'https://api.ievangelize.app/storage/v1/object/public/misc/avatar.jpg',
                            'https://api.ievangelize.app/storage/v1/object/public/misc/avatar.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'bb454irs' /* Welcome back, */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'f5y668lf' /* the Harvest Is Ready */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2.1,
                            color: Color(0x25000000),
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
                          width: 24.0,
                          height: 24.0,
                          fit: BoxFit.contain,
                          alignment: const Alignment(0.0, 0.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 24.0, 16.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'Impact',
                                queryParameters: {
                                  'shares': serializeParam(
                                    homeUsersRow?.impact,
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 95.0,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).mainDarkDark,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 42.0,
                                      height: 42.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        size: 24.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          14.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '601ez9xh' /* My Impact */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  fontSize: 26.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'igwa21pc' /* Gospel shares & missions */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            const AlignmentDirectional(1.0, 0.0),
                                        child: AutoSizeText(
                                          valueOrDefault<String>(
                                            homeUsersRow?.impact?.toString(),
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                fontSize: 40.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 0.0),
                          child: FutureBuilder<List<StoriesRow>>(
                            future: FFAppState().story(
                              requestFn: () => StoriesTable().querySingleRow(
                                queryFn: (q) => q.eqOrNull(
                                  'is_active',
                                  true,
                                ),
                              ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return const QuoteLoadingWidget();
                              }
                              List<StoriesRow> stackStoriesRowList =
                                  snapshot.data!;

                              final stackStoriesRow =
                                  stackStoriesRowList.isNotEmpty
                                      ? stackStoriesRowList.first
                                      : null;

                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'StoryViewer',
                                    queryParameters: {
                                      'story': serializeParam(
                                        stackStoriesRow,
                                        ParamType.SupabaseRow,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                      ),
                                    },
                                  );
                                },
                                child: Stack(
                                  alignment: const AlignmentDirectional(0.0, 1.0),
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: Hero(
                                        tag: valueOrDefault<String>(
                                          stackStoriesRow?.thumbnailUrl,
                                          'https://api.ievangelize.app/storage/v1/object/public/stories/quote_4_thumb.png',
                                        ),
                                        transitionOnUserGestures: true,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                const Duration(milliseconds: 300),
                                            fadeOutDuration:
                                                const Duration(milliseconds: 300),
                                            imageUrl: valueOrDefault<String>(
                                              stackStoriesRow?.thumbnailUrl,
                                              'https://api.ievangelize.app/storage/v1/object/public/stories/quote_4_thumb.png',
                                            ),
                                            width: double.infinity,
                                            height: 220.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await actions.shareFile(
                                                context,
                                                stackStoriesRow!.thumbnailUrl!,
                                              );
                                            },
                                            child: Container(
                                              width: 35.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0x52000000),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 3.0),
                                                child: Icon(
                                                  Icons.ios_share,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 16.0,
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
                                                'StoryViewer',
                                                queryParameters: {
                                                  'story': serializeParam(
                                                    stackStoriesRow,
                                                    ParamType.SupabaseRow,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      const TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType.fade,
                                                  ),
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 35.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0x52000000),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Icon(
                                                Icons.open_in_full_sharp,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                size: 18.0,
                                              ),
                                            ),
                                          ),
                                        ]
                                            .divide(const SizedBox(width: 16.0))
                                            .addToEnd(const SizedBox(width: 8.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 24.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'rlygg482' /* Tools */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        if (getRemoteConfigBool('jad'))
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('situation');
                                    },
                                    child: Stack(
                                      alignment: const AlignmentDirectional(1.0, 1.0),
                                      children: [
                                        Container(
                                          width: 330.0,
                                          height: 156.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .mainDarkDark,
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    14.0, 16.0, 12.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/zap.png',
                                                        width: 28.0,
                                                        height: 28.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'l3tvpeff' /* Conversation Starters  */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'gp5tqte0' /* Personalized conversation star... */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ].divide(const SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 8.0),
                                          child: FlutterFlowIconButton(
                                            borderRadius: 100.0,
                                            buttonSize: 40.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                            icon: Icon(
                                              Icons.arrow_outward_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              context.pushNamed('situation');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('EquippingCardInfo');
                                    },
                                    child: Stack(
                                      alignment: const AlignmentDirectional(1.0, 1.0),
                                      children: [
                                        Container(
                                          width: 330.0,
                                          height: 156.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .mainDarkDark,
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    14.0, 16.0, 12.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.asset(
                                                        'assets/images/business-card.png',
                                                        width: 28.0,
                                                        height: 28.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'vaf0xzhl' /* Equipping Card */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'cifmva7f' /* A 9-step gospel tool for effec... */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ].divide(const SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 8.0),
                                          child: FlutterFlowIconButton(
                                            borderRadius: 100.0,
                                            buttonSize: 40.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                            icon: Icon(
                                              Icons.arrow_outward_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              context.pushNamed(
                                                  'EquippingCardInfo');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                                    .divide(const SizedBox(width: 16.0))
                                    .addToStart(const SizedBox(width: 16.0))
                                    .addToEnd(const SizedBox(width: 16.0)),
                              ),
                            ),
                          ),
                        if (!getRemoteConfigBool('jad'))
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 10.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('situation');
                                    },
                                    child: Stack(
                                      alignment: const AlignmentDirectional(1.0, 1.0),
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 156.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .mainDarkDark,
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    14.0, 16.0, 12.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/zap.png',
                                                        width: 28.0,
                                                        height: 28.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '1mtw7g13' /* Conversation Starters  */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'qk3buq8b' /* Personalized conversation star... */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ].divide(const SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 8.0),
                                          child: FlutterFlowIconButton(
                                            borderRadius: 100.0,
                                            buttonSize: 40.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                            icon: Icon(
                                              Icons.arrow_outward_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              context.pushNamed('situation');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 32.0, 0.0, 0.0),
                          child: FutureBuilder<List<CategoriesRow>>(
                            future: FFAppState().homeCategories(
                              requestFn: () => CategoriesTable().querySingleRow(
                                queryFn: (q) => q
                                    .eqOrNull(
                                      'home_page',
                                      true,
                                    )
                                    .order('created_at'),
                              ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 0.0, 0.0),
                                  child: HomeVideoLoadingWidget(),
                                );
                              }
                              List<CategoriesRow> columnCategoriesRowList =
                                  snapshot.data!;

                              final columnCategoriesRow =
                                  columnCategoriesRowList.isNotEmpty
                                      ? columnCategoriesRowList.first
                                      : null;

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            columnCategoriesRow?.title,
                                            'Everyday Evangelism',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Flexible(
                                          child: Align(
                                            alignment:
                                                const AlignmentDirectional(1.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed('Explore');
                                              },
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'ytjurev3' /* SEE ALL > */,
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
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 0.0, 0.0),
                                    child: FutureBuilder<List<ResourcesRow>>(
                                      future: FFAppState().resources(
                                        uniqueQueryKey: valueOrDefault<String>(
                                          columnCategoriesRow?.id.toString(),
                                          '7',
                                        ),
                                        requestFn: () =>
                                            ResourcesTable().queryRows(
                                          queryFn: (q) => q
                                              .eqOrNull(
                                                'category_id',
                                                columnCategoriesRow?.id,
                                              )
                                              .order('order'),
                                          limit: 10,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return const HomeVideoLoadingWidget();
                                        }
                                        List<ResourcesRow> rowResourcesRowList =
                                            snapshot.data!;

                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                    rowResourcesRowList.length,
                                                    (rowIndex) {
                                              final rowResourcesRow =
                                                  rowResourcesRowList[rowIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
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
                                                            ParamType.String,
                                                          ),
                                                          'title':
                                                              serializeParam(
                                                            rowResourcesRow
                                                                .title,
                                                            ParamType.String,
                                                          ),
                                                          'description':
                                                              serializeParam(
                                                            rowResourcesRow
                                                                .subTitle,
                                                            ParamType.String,
                                                          ),
                                                          'shareURL':
                                                              serializeParam(
                                                            rowResourcesRow
                                                                .shareUrl,
                                                            ParamType.String,
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
                                                            ParamType.String,
                                                          ),
                                                          'description':
                                                              serializeParam(
                                                            rowResourcesRow
                                                                .description,
                                                            ParamType.String,
                                                          ),
                                                          'videoURL':
                                                              serializeParam(
                                                            rowResourcesRow
                                                                .mediaUrl,
                                                            ParamType.String,
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
                                                            ParamType.String,
                                                          ),
                                                          'categoryTitle':
                                                              serializeParam(
                                                            columnCategoriesRow
                                                                ?.title,
                                                            ParamType.String,
                                                          ),
                                                          'categoryThumbnail':
                                                              serializeParam(
                                                            columnCategoriesRow
                                                                ?.posterUrl,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    }
                                                  } else {
                                                    context.pushNamed(
                                                      'AudioPlayer',
                                                      queryParameters: {
                                                        'title': serializeParam(
                                                          rowResourcesRow.title,
                                                          ParamType.String,
                                                        ),
                                                        'thumbnailURL':
                                                            serializeParam(
                                                          rowResourcesRow
                                                              .thumbnailUrl,
                                                          ParamType.String,
                                                        ),
                                                        'subTitle':
                                                            serializeParam(
                                                          rowResourcesRow
                                                              .subTitle,
                                                          ParamType.String,
                                                        ),
                                                        'audioURL':
                                                            serializeParam(
                                                          rowResourcesRow
                                                              .mediaUrl,
                                                          ParamType.String,
                                                        ),
                                                        'shareURL':
                                                            serializeParam(
                                                          rowResourcesRow
                                                              .shareUrl,
                                                          ParamType.String,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 149.0,
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
                                                                'https://picsum.photos/seed/80/600',
                                                              ),
                                                              width: 149.0,
                                                              height: 240.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 1.0),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
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
                                                                    width: 18.0,
                                                                    height:
                                                                        18.0,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Color(
                                                                          0x9A000000),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .play_arrow,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
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
                                                                      color: const Color(
                                                                          0x9A000000),
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                1.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                          ),
                                                                      elevation:
                                                                          0.0,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
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
                                                        valueOrDefault<String>(
                                                          rowResourcesRow
                                                              .subTitle,
                                                          'Sub title',
                                                        ).maybeHandleOverflow(
                                                          maxChars: 16,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  2.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          rowResourcesRow.title,
                                                          'Tinotenda Chiwar',
                                                        ).maybeHandleOverflow(
                                                          maxChars: 15,
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
                                                                      .normal,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                                .divide(const SizedBox(width: 16.0))
                                                .addToEnd(
                                                    const SizedBox(width: 16.0)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 12.0)),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 32.0, 16.0, 0.0),
                          child: FutureBuilder<List<ChallengeWeeksRow>>(
                            future: ChallengeWeeksTable().querySingleRow(
                              queryFn: (q) => q
                                  .eqOrNull(
                                    'in_progress',
                                    true,
                                  )
                                  .eqOrNull(
                                    'church_id',
                                    homeUsersRow?.churchId,
                                  ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return const MissionsLoadingWidget();
                              }
                              List<ChallengeWeeksRow>
                                  columnChallengeWeeksRowList = snapshot.data!;

                              // Return an empty Container when the item does not exist.
                              if (snapshot.data!.isEmpty) {
                                return Container();
                              }
                              final columnChallengeWeeksRow =
                                  columnChallengeWeeksRowList.isNotEmpty
                                      ? columnChallengeWeeksRowList.first
                                      : null;

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          columnChallengeWeeksRow?.title,
                                          'Weekly Missions',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: FutureBuilder<List<UserMissionsRow>>(
                                      future: UserMissionsTable().queryRows(
                                        queryFn: (q) => q.eqOrNull(
                                          'user_id',
                                          currentUserUid,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return const MissionsLoadingWidget();
                                        }
                                        List<UserMissionsRow>
                                            containerUserMissionsRowList =
                                            snapshot.data!;

                                        return Container(
                                          decoration: const BoxDecoration(),
                                          child:
                                              FutureBuilder<List<MissionsRow>>(
                                            future: FFAppState().missions(
                                              requestFn: () =>
                                                  MissionsTable().queryRows(
                                                queryFn: (q) => q
                                                    .eqOrNull(
                                                      'challenge_week_id',
                                                      columnChallengeWeeksRow
                                                          ?.id,
                                                    )
                                                    .order('created_at',
                                                        ascending: true),
                                              ),
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return const MissionsLoadingWidget();
                                              }
                                              List<MissionsRow>
                                                  listViewMissionsRowList =
                                                  snapshot.data!;

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    listViewMissionsRowList
                                                        .length,
                                                separatorBuilder: (_, __) =>
                                                    const SizedBox(height: 14.0),
                                                itemBuilder:
                                                    (context, listViewIndex) {
                                                  final listViewMissionsRow =
                                                      listViewMissionsRowList[
                                                          listViewIndex];
                                                  return wrapWithModel(
                                                    model: _model.missionModels
                                                        .getModel(
                                                      listViewMissionsRow.id,
                                                      listViewIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    updateOnChange: true,
                                                    child: MissionWidget(
                                                      key: Key(
                                                        'Keyguc_${listViewMissionsRow.id}',
                                                      ),
                                                      missionTitle:
                                                          listViewMissionsRow
                                                              .title!,
                                                      peopleCompleted:
                                                          formatNumber(
                                                        listViewMissionsRow
                                                            .peopleCompleted!,
                                                        formatType:
                                                            FormatType.compact,
                                                      ),
                                                      mission:
                                                          listViewMissionsRow,
                                                      userMissions:
                                                          containerUserMissionsRowList,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ].addToEnd(const SizedBox(height: 100.0)),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: wrapWithModel(
                      model: _model.navBarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: const NavBarWidget(
                        selectedPage: 'home',
                      ),
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
