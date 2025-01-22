import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'large_btn_model.dart';
export 'large_btn_model.dart';

class LargeBtnWidget extends StatefulWidget {
  const LargeBtnWidget({
    super.key,
    required this.text,
    Color? color,
    required this.action,
    Color? textColor,
  })  : color = color ?? Colors.black,
        textColor = textColor ?? Colors.black;

  final String? text;
  final Color color;
  final Future Function()? action;
  final Color textColor;

  @override
  State<LargeBtnWidget> createState() => _LargeBtnWidgetState();
}

class _LargeBtnWidgetState extends State<LargeBtnWidget> {
  late LargeBtnModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LargeBtnModel());
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
        height: 54.0,
        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: widget.color,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Inter',
              color: widget.textColor,
              fontSize: 20.0,
              letterSpacing: 0.0,
            ),
        elevation: 0.0,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
    );
  }
}
