import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'quote3_model.dart';
export 'quote3_model.dart';

class Quote3Widget extends StatefulWidget {
  const Quote3Widget({super.key});

  @override
  State<Quote3Widget> createState() => _Quote3WidgetState();
}

class _Quote3WidgetState extends State<Quote3Widget> {
  late Quote3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Quote3Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'quote3'});
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
        body: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (isiOS) {
              await actions.appTrackingDialog();
            }

            context.pushNamed(
              'getStarted',
              extra: <String, dynamic>{
                kTransitionInfoKey: const TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );

            HapticFeedback.mediumImpact();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? 'assets/images/background_noise.png'
                      : 'assets/images/background_noise.png',
                ).image,
              ),
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 100.0,
                      child: custom_widgets.TypewriterAnimation(
                        width: double.infinity,
                        height: 100.0,
                        fontSize: 24.0,
                        fontColor: FlutterFlowTheme.of(context).info,
                        textSpeed: 35,
                        text: 'preach the Gospel to all creation.\"',
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 48.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '10swbcmv' /* TAP TO CONTINUE */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
