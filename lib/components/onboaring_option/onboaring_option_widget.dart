import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboaring_option_model.dart';
export 'onboaring_option_model.dart';

class OnboaringOptionWidget extends StatefulWidget {
  const OnboaringOptionWidget({
    super.key,
    this.text,
  });

  final String? text;

  @override
  State<OnboaringOptionWidget> createState() => _OnboaringOptionWidgetState();
}

class _OnboaringOptionWidgetState extends State<OnboaringOptionWidget> {
  late OnboaringOptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboaringOptionModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        _model.selected = true;
        _model.updatePage(() {});
      },
      child: Container(
        width: double.infinity,
        height: 52.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            _model.selected
                ? FlutterFlowTheme.of(context).secondary
                : Color(0xFFF8F7FC),
            Color(0xFFF8F7FC),
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: valueOrDefault<Color>(
              _model.selected ? Color(0xFF6A55EA) : Color(0xFFDFDFDF),
              Color(0xFFDFDFDF),
            ),
            width: 1.0,
          ),
        ),
        alignment: AlignmentDirectional(-1.0, 0.0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                valueOrDefault<String>(
                  widget.text,
                  'Male',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: _model.selected
                          ? FlutterFlowTheme.of(context).primaryBackground
                          : FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
