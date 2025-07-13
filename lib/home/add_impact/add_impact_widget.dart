import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_impact_model.dart';
export 'add_impact_model.dart';

class AddImpactWidget extends StatefulWidget {
  const AddImpactWidget({
    super.key,
    required this.gospelShares,
  });

  final int? gospelShares;

  static String routeName = 'AddImpact';
  static String routePath = 'addImpact';

  @override
  State<AddImpactWidget> createState() => _AddImpactWidgetState();
}

class _AddImpactWidgetState extends State<AddImpactWidget> {
  late AddImpactModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddImpactModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'AddImpact'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.gospelSharesState = widget.gospelShares!;
      safeSetState(() {});
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
              Icons.close_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
          ),
          actions: [],
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
              Flexible(
                child: Text(
                  FFLocalizations.of(context).getText(
                    '8e3tekz4' /* How many people
did you share
... */
                    ,
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w800,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 28.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w800,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(0.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: FlutterFlowCountController(
                      decrementIconBuilder: (enabled) => Icon(
                        Icons.do_disturb_on_outlined,
                        color: enabled
                            ? FlutterFlowTheme.of(context).blackWhite
                            : FlutterFlowTheme.of(context).blackWhite,
                        size: 34.0,
                      ),
                      incrementIconBuilder: (enabled) => Icon(
                        Icons.add_circle_outline_outlined,
                        color: enabled
                            ? FlutterFlowTheme.of(context).blackWhite
                            : FlutterFlowTheme.of(context).blackWhite,
                        size: 34.0,
                      ),
                      countBuilder: (count) => Text(
                        count.toString(),
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .fontStyle,
                              ),
                              fontSize: 40.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontStyle,
                            ),
                      ),
                      count: _model.countControllerValue ??= 0,
                      updateCount: (count) => safeSetState(
                          () => _model.countControllerValue = count),
                      stepSize: 1,
                      minimum: 0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (!FFAppState().madeFirstImpact) {
                      await actions.requestReview();
                      FFAppState().madeFirstImpact = true;
                      safeSetState(() {});
                    }
                    _model.gospelSharesState =
                        _model.gospelSharesState + _model.countControllerValue!;
                    safeSetState(() {});
                    await UsersTable().update(
                      data: {
                        'impact': _model.gospelSharesState,
                      },
                      matchingRows: (rows) => rows.eqOrNull(
                        'id',
                        currentUserUid,
                      ),
                    );
                    await ImpactTable().insert({
                      'user_id': currentUserUid,
                      'title':
                          'Gospel share: You shared the gospel with ${_model.countControllerValue?.toString()} person(s)',
                    });
                    FFAppState().clearProfileCache();

                    context.pushNamed(
                      RecordInfoChoiceWidget.routeName,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  },
                  text: FFLocalizations.of(context).getText(
                    'qu8pj7tn' /* CONFIRM */,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: Colors.white,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  showLoadingIndicator: false,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(32.0, 16.0, 32.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.goNamed(
                      HomeWidget.routeName,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.topToBottom,
                        ),
                      },
                    );
                  },
                  text: FFLocalizations.of(context).getText(
                    'snwjxv74' /* CANCEL */,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).blackWhite,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
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
