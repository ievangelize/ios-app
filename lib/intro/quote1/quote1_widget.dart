import '/auth/base_auth_user_provider.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'quote1_model.dart';
export 'quote1_model.dart';

class Quote1Widget extends StatefulWidget {
  const Quote1Widget({super.key});

  @override
  State<Quote1Widget> createState() => _Quote1WidgetState();
}

class _Quote1WidgetState extends State<Quote1Widget> {
  late Quote1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Quote1Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'quote1'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
      if (FFAppState().completedOnboarding) {
        if (loggedIn) {
          context.goNamed(
            'home',
            extra: <String, dynamic>{
              kTransitionInfoKey: const TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );
        } else {
          context.goNamed(
            'homeNoAuth',
            extra: <String, dynamic>{
              kTransitionInfoKey: const TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );
        }
      }
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
        body: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pushNamed(
              'quote2',
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
                        textSpeed: 25,
                        text: 'And Jesus said...',
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
                        '1k2cp01u' /* TAP TO CONTINUE */,
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
