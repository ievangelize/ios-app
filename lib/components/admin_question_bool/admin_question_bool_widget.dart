import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_question_bool_model.dart';
export 'admin_question_bool_model.dart';

class AdminQuestionBoolWidget extends StatefulWidget {
  const AdminQuestionBoolWidget({
    super.key,
    this.selected,
  });

  final String? selected;

  @override
  State<AdminQuestionBoolWidget> createState() =>
      _AdminQuestionBoolWidgetState();
}

class _AdminQuestionBoolWidgetState extends State<AdminQuestionBoolWidget> {
  late AdminQuestionBoolModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminQuestionBoolModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            HapticFeedback.lightImpact();
            _model.selectedId = 'yes';
            safeSetState(() {});
            FFAppState().onboardingBtn = true;
            _model.updatePage(() {});
          },
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: 52.0,
            ),
            decoration: BoxDecoration(
              color: valueOrDefault<Color>(
                _model.selectedId == 'yes'
                    ? FlutterFlowTheme.of(context).secondary
                    : Color(0xFFF8F7FC),
                Color(0xFFF8F7FC),
              ),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: valueOrDefault<Color>(
                  _model.selectedId == 'yes'
                      ? Color(0xFF6A55EA)
                      : Color(0xFFDFDFDF),
                  Color(0xFFDFDFDF),
                ),
                width: 1.0,
              ),
            ),
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 8.0, 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Text(
                      'Yes',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: _model.selectedId == 'yes'
                                ? FlutterFlowTheme.of(context).info
                                : Colors.black,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                ],
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
            HapticFeedback.lightImpact();
            _model.selectedId = 'no';
            safeSetState(() {});
            FFAppState().onboardingBtn = true;
            _model.updatePage(() {});
          },
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: 52.0,
            ),
            decoration: BoxDecoration(
              color: valueOrDefault<Color>(
                _model.selectedId == 'no'
                    ? FlutterFlowTheme.of(context).secondary
                    : Color(0xFFF8F7FC),
                Color(0xFFF8F7FC),
              ),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: valueOrDefault<Color>(
                  _model.selectedId == 'no'
                      ? Color(0xFF6A55EA)
                      : Color(0xFFDFDFDF),
                  Color(0xFFDFDFDF),
                ),
                width: 1.0,
              ),
            ),
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 8.0, 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Text(
                      'No',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: _model.selectedId == 'no'
                                ? FlutterFlowTheme.of(context).info
                                : Colors.black,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ].divide(SizedBox(height: 12.0)),
    );
  }
}
