import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboaring_btn_outline_model.dart';
export 'onboaring_btn_outline_model.dart';

class OnboaringBtnOutlineWidget extends StatefulWidget {
  const OnboaringBtnOutlineWidget({
    super.key,
    required this.text,
    Color? color,
    required this.action,
    Color? textColor,
  })  : this.color = color ?? Colors.black,
        this.textColor = textColor ?? Colors.black;

  final String? text;
  final Color color;
  final Future Function()? action;
  final Color textColor;

  @override
  State<OnboaringBtnOutlineWidget> createState() =>
      _OnboaringBtnOutlineWidgetState();
}

class _OnboaringBtnOutlineWidgetState extends State<OnboaringBtnOutlineWidget> {
  late OnboaringBtnOutlineModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboaringBtnOutlineModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        await widget.action?.call();
      },
      text: widget.text!,
      options: FFButtonOptions(
        width: double.infinity,
        height: 59.0,
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: Color(0x0E6A55EA),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
              color: FlutterFlowTheme.of(context).secondary,
              fontSize: 20.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
            ),
        elevation: 0.0,
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).secondary,
          width: 1.23,
        ),
        borderRadius: BorderRadius.circular(50.0),
      ),
      showLoadingIndicator: false,
    );
  }
}
