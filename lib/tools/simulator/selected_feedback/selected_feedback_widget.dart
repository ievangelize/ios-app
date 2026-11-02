import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'selected_feedback_model.dart';
export 'selected_feedback_model.dart';

class SelectedFeedbackWidget extends StatefulWidget {
  const SelectedFeedbackWidget({
    super.key,
    required this.feedback,
  });

  final SimulatorFeedbackRow? feedback;

  static String routeName = 'selectedFeedback';
  static String routePath = 'selectedFeedback';

  @override
  State<SelectedFeedbackWidget> createState() => _SelectedFeedbackWidgetState();
}

class _SelectedFeedbackWidgetState extends State<SelectedFeedbackWidget> {
  late SelectedFeedbackModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectedFeedbackModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'selectedFeedback'});
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
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 25.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Feedback',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (isiOS) {
                    _model.response = await actions.cupertinoConfirmationDialog(
                      context,
                      'Delete feedback?',
                      'This can\'t be undone.',
                      'Cancel',
                      'Delete',
                      FlutterFlowTheme.of(context).error,
                      FlutterFlowTheme.of(context).secondary,
                    );
                    if (_model.response!) {
                      await SimulatorFeedbackTable().delete(
                        matchingRows: (rows) => rows
                            .eqOrNull(
                              'id',
                              widget.feedback?.id,
                            )
                            .eqOrNull(
                              'user_id',
                              currentUserUid,
                            ),
                      );
                      FFAppState().clearSimulatorFeedbackCache();

                      context.goNamed(SimulatorHistoryWidget.routeName);
                    }
                  } else {
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Delete feedback?'),
                              content: Text('This can\'t be undone.'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                    if (confirmDialogResponse) {
                      await SimulatorFeedbackTable().delete(
                        matchingRows: (rows) => rows
                            .eqOrNull(
                              'id',
                              widget.feedback?.id,
                            )
                            .eqOrNull(
                              'user_id',
                              currentUserUid,
                            ),
                      );
                      FFAppState().clearSimulatorFeedbackCache();

                      context.goNamed(SimulatorHistoryWidget.routeName);
                    }
                  }

                  safeSetState(() {});
                },
                child: FaIcon(
                  FaIconData(const IconData(/* trashAlt */ 0xf2ed,
                      fontFamily: 'FontAwesomeRegular',
                      fontPackage: 'font_awesome_flutter')),
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 25.0,
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 32.0, 16.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        custom_widgets.CustomMarkdown(
                          width: double.infinity,
                          height: 50.0,
                          fontSize: 16.0,
                          textColor: FlutterFlowTheme.of(context).primaryText,
                          blockquoteBackground:
                              FlutterFlowTheme.of(context).blackAlternate,
                          blockquoteTextColor:
                              FlutterFlowTheme.of(context).primaryText,
                          data: widget.feedback!.feedbackText!,
                        ),
                      ].addToEnd(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                child: wrapWithModel(
                  model: _model.largeBtnModel,
                  updateCallback: () => safeSetState(() {}),
                  child: LargeBtnWidget(
                    text: 'Done',
                    color: FlutterFlowTheme.of(context).secondary,
                    textColor: FlutterFlowTheme.of(context).info,
                    action: () async {
                      context.safePop();
                    },
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
