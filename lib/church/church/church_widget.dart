import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'church_model.dart';
export 'church_model.dart';

class ChurchWidget extends StatefulWidget {
  const ChurchWidget({super.key});

  @override
  State<ChurchWidget> createState() => _ChurchWidgetState();
}

class _ChurchWidgetState extends State<ChurchWidget> {
  late ChurchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChurchModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Church'});
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
              Icons.arrow_back_rounded,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 15.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeOutDuration: const Duration(milliseconds: 500),
                      imageUrl:
                          'https://t3.ftcdn.net/jpg/02/99/86/76/360_F_299867677_MImEvpPSnCpJYxmcQT4d9FE2eCBdDl0Q.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'rmtmtdli' /* You're part of: */,
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'woolvm0h' /* Eagle Mountain International C... */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (isiOS) {
                      _model.response =
                          await actions.cupertinoConfirmationDialog(
                        context,
                        'Leave this church?',
                        'If you leave this church, you can always join it again.',
                        'Cancel',
                        'Leave',
                        FlutterFlowTheme.of(context).error,
                        FlutterFlowTheme.of(context).secondary,
                      );
                      if (_model.response!) {
                        FFAppState().clearProfileCache();
                        await UsersTable().update(
                          data: {
                            'joined_church': false,
                            'church_id': null,
                          },
                          matchingRows: (rows) => rows.eqOrNull(
                            'id',
                            currentUserUid,
                          ),
                        );

                        context.pushNamed(
                          'home',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.bottomToTop,
                            ),
                          },
                        );
                      }
                    } else {
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: const Text('Leave this church?'),
                                content: const Text(
                                    'If you leave this church, you can always join it again.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: const Text('Leave'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        FFAppState().clearProfileCache();
                        await UsersTable().update(
                          data: {
                            'joined_church': false,
                            'church_id': null,
                          },
                          matchingRows: (rows) => rows.eqOrNull(
                            'id',
                            currentUserUid,
                          ),
                        );

                        context.pushNamed(
                          'home',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.bottomToTop,
                            ),
                          },
                        );
                      }
                    }

                    safeSetState(() {});
                  },
                  text: FFLocalizations.of(context).getText(
                    'jeog923c' /* LEAVE */,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).error,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  showLoadingIndicator: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
