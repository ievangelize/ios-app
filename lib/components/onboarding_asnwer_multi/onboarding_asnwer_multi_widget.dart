import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'onboarding_asnwer_multi_model.dart';
export 'onboarding_asnwer_multi_model.dart';

class OnboardingAsnwerMultiWidget extends StatefulWidget {
  const OnboardingAsnwerMultiWidget({
    super.key,
    required this.questionIndex,
    this.answersJson,
  });

  final int? questionIndex;
  final dynamic answersJson;

  @override
  State<OnboardingAsnwerMultiWidget> createState() =>
      _OnboardingAsnwerMultiWidgetState();
}

class _OnboardingAsnwerMultiWidgetState
    extends State<OnboardingAsnwerMultiWidget> {
  late OnboardingAsnwerMultiModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingAsnwerMultiModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) {
        final answerList = getJsonField(
          widget.answersJson,
          r'''$.answers''',
        ).toList();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(answerList.length, (answerListIndex) {
            final answerListItem = answerList[answerListIndex];
            return InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                HapticFeedback.lightImpact();
                FFAppState().onboardingBtn = true;
                _model.updatePage(() {});
                if (FFAppState()
                    .onboardingSnapshot
                    .containsMap(<String, String>{
                  getJsonField(
                    widget.answersJson,
                    r'''$.key''',
                  ).toString(): getJsonField(
                    answerListItem,
                    r'''$.id''',
                  ).toString(),
                })) {
                  _model.removeFromSelectedId(getJsonField(
                    answerListItem,
                    r'''$''',
                  ));
                  safeSetState(() {});
                  FFAppState().removeFromOnboardingSnapshot(<String, String>{
                    getJsonField(
                      widget.answersJson,
                      r'''$.key''',
                    ).toString(): getJsonField(
                      answerListItem,
                      r'''$.id''',
                    ).toString(),
                  });
                  safeSetState(() {});
                  FFAppState().selectedMultiAnswers =
                      FFAppState().selectedMultiAnswers + -1;
                  safeSetState(() {});
                } else {
                  _model.addToSelectedId(getJsonField(
                    answerListItem,
                    r'''$''',
                  ));
                  safeSetState(() {});
                  FFAppState().addToOnboardingSnapshot(<String, String>{
                    getJsonField(
                      widget.answersJson,
                      r'''$.key''',
                    ).toString(): getJsonField(
                      answerListItem,
                      r'''$.id''',
                    ).toString(),
                  });
                  safeSetState(() {});
                  FFAppState().selectedMultiAnswers =
                      FFAppState().selectedMultiAnswers + 1;
                  safeSetState(() {});
                }
              },
              child: Container(
                width: double.infinity,
                height: 52.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    _model.selectedId.containsMap(getJsonField(
                      answerListItem,
                      r'''$''',
                    ))
                        ? FlutterFlowTheme.of(context).secondary
                        : Color(0xFFF8F7FC),
                    Color(0xFFF8F7FC),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: valueOrDefault<Color>(
                      _model.selectedId.containsMap(getJsonField(
                        answerListItem,
                        r'''$''',
                      ))
                          ? Color(0xFF6A55EA)
                          : Color(0xFFDFDFDF),
                      Color(0xFFDFDFDF),
                    ),
                    width: 1.0,
                  ),
                ),
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        getJsonField(
                          answerListItem,
                          r'''$.label''',
                        ).toString(),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: _model.selectedId.containsMap(getJsonField(
                                answerListItem,
                                r'''$''',
                              ))
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
                      Flexible(
                        child: Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: FaIcon(
                            FontAwesomeIcons.solidCheckCircle,
                            color: valueOrDefault<Color>(
                              _model.selectedId.containsMap(getJsonField(
                                answerListItem,
                                r'''$''',
                              ))
                                  ? FlutterFlowTheme.of(context).info
                                  : Colors.transparent,
                              Colors.transparent,
                            ),
                            size: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).divide(SizedBox(height: 12.0)),
        );
      },
    );
  }
}
