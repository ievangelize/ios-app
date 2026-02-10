import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'tap_to_complete_btn_model.dart';
export 'tap_to_complete_btn_model.dart';

class TapToCompleteBtnWidget extends StatefulWidget {
  const TapToCompleteBtnWidget({
    super.key,
    required this.action,
  });

  final Future Function()? action;

  @override
  State<TapToCompleteBtnWidget> createState() => _TapToCompleteBtnWidgetState();
}

class _TapToCompleteBtnWidgetState extends State<TapToCompleteBtnWidget> {
  late TapToCompleteBtnModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TapToCompleteBtnModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          if (_model.btnTapped) {
            return;
          }

          HapticFeedback.mediumImpact();
          _model.btnTapped = true;
          safeSetState(() {});
          await Future.delayed(
            Duration(
              milliseconds: 1000,
            ),
          );
          await widget.action?.call();
        },
        child: Container(
          height: 54.0,
          child: Stack(
            alignment: AlignmentDirectional(0.0, 0.0),
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                curve: Curves.easeIn,
                width: double.infinity,
                height: 54.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    _model.btnTapped
                        ? FlutterFlowTheme.of(context).secondary
                        : Color(0x1A6A55EA),
                    Color(0x1A6A55EA),
                  ),
                  borderRadius: BorderRadius.circular(54.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).secondary,
                    width: 1.0,
                  ),
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Visibility(
                  visible: !_model.btnTapped,
                  child: Text(
                    'Tap to Complete',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondary,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ),
              if (_model.btnTapped)
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Lottie.asset(
                    'assets/jsons/Success_(3).json',
                    width: 54.0,
                    height: 54.0,
                    fit: BoxFit.contain,
                    repeat: false,
                    animate: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
