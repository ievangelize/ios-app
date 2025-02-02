import '/auth/base_auth_user_provider.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'tools_model.dart';
export 'tools_model.dart';

class ToolsWidget extends StatefulWidget {
  const ToolsWidget({super.key});

  @override
  State<ToolsWidget> createState() => _ToolsWidgetState();
}

class _ToolsWidgetState extends State<ToolsWidget> {
  late ToolsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ToolsModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Tools'});
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
                  width: 34.0,
                  height: 34.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).alternate,
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
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'bhwio78u' /* Tools */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineLarge.override(
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
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: 970.0,
            ),
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'db0qpm23' /* 2 tools you can use for everyd... */,
                        ),
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (loggedIn) {
                            context.pushNamed('situation');
                          } else {
                            context.pushNamed('situationNoAuth');
                          }
                        },
                        child: Stack(
                          alignment: const AlignmentDirectional(1.0, 1.0),
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  1.0, 0.0, 0.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                height: 175.0,
                                decoration: BoxDecoration(
                                  color:
                                      FlutterFlowTheme.of(context).mainDarkDark,
                                  borderRadius: BorderRadius.circular(22.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      14.0, 16.0, 12.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'w05r76ny' /* Conversation starters */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'b3ec2olj' /* Get personalized conversation ... */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ].divide(const SizedBox(height: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 8.0, 8.0),
                              child: FlutterFlowIconButton(
                                borderRadius: 100.0,
                                buttonSize: 40.0,
                                fillColor:
                                    FlutterFlowTheme.of(context).secondary,
                                icon: Icon(
                                  Icons.arrow_outward_rounded,
                                  color: FlutterFlowTheme.of(context).info,
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
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
                              height: 175.0,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).mainDarkDark,
                                borderRadius: BorderRadius.circular(22.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    14.0, 16.0, 12.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'rmg2kt8x' /* Equipping Card */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '11ol5y3v' /* This equipping card presents a... */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 8.0, 8.0),
                              child: FlutterFlowIconButton(
                                borderRadius: 100.0,
                                buttonSize: 40.0,
                                fillColor:
                                    FlutterFlowTheme.of(context).secondary,
                                icon: Icon(
                                  Icons.arrow_outward_rounded,
                                  color: FlutterFlowTheme.of(context).info,
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
            ),
          ),
        ),
      ),
    );
  }
}
