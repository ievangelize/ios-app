import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboaring_btn_model.dart';
export 'onboaring_btn_model.dart';

class OnboaringBtnWidget extends StatefulWidget {
  const OnboaringBtnWidget({
    super.key,
    required this.text,
    Color? color,
    required this.action,
    Color? textColor,
    required this.disableBtn,
  })  : this.color = color ?? Colors.black,
        this.textColor = textColor ?? Colors.black;

  final String? text;
  final Color color;
  final Future Function()? action;
  final Color textColor;
  final bool? disableBtn;

  @override
  State<OnboaringBtnWidget> createState() => _OnboaringBtnWidgetState();
}

class _OnboaringBtnWidgetState extends State<OnboaringBtnWidget> {
  late OnboaringBtnModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboaringBtnModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: !widget.disableBtn!
          ? null
          : () async {
              HapticFeedback.lightImpact();
              await widget.action?.call();
            },
      text: widget.text!,
      options: FFButtonOptions(
        width: double.infinity,
        height: 59.0,
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: widget.color,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
              color: widget.textColor,
              fontSize: 20.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
            ),
        elevation: 0.0,
        borderRadius: BorderRadius.circular(50.0),
        disabledColor: Color(0x656A55EA),
        disabledTextColor: Color(0x64FFFFFF),
      ),
      showLoadingIndicator: false,
    );
  }
}
