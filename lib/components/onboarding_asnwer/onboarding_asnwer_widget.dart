import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'onboarding_asnwer_model.dart';
export 'onboarding_asnwer_model.dart';

class OnboardingAsnwerWidget extends StatefulWidget {
  const OnboardingAsnwerWidget({
    super.key,
    this.answersJson,
    required this.questionIndex,
  });

  final dynamic answersJson;
  final int? questionIndex;

  @override
  State<OnboardingAsnwerWidget> createState() => _OnboardingAsnwerWidgetState();
}

class _OnboardingAsnwerWidgetState extends State<OnboardingAsnwerWidget> {
  late OnboardingAsnwerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingAsnwerModel());
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
                _model.selectedId = getJsonField(
                  answerListItem,
                  r'''$''',
                );
                safeSetState(() {});
                FFAppState().onboardingBtn = true;
                _model.updatePage(() {});
                if (FFAppState().onboardingKv.containsMap(getJsonField(
                      widget.answersJson,
                      r'''$.key''',
                    ))) {
                  FFAppState().updateOnboardingSnapshotAtIndex(
                    widget.questionIndex!,
                    (_) => <String, String>{
                      getJsonField(
                        widget.answersJson,
                        r'''$.key''',
                      ).toString(): getJsonField(
                        answerListItem,
                        r'''$.id''',
                      ).toString(),
                    },
                  );
                  safeSetState(() {});
                } else {
                  FFAppState().addToOnboardingKv(getJsonField(
                    widget.answersJson,
                    r'''$.key''',
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
                }
              },
              child: Container(
                width: double.infinity,
                height: 52.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    getJsonField(
                              answerListItem,
                              r'''$''',
                            ) ==
                            _model.selectedId
                        ? FlutterFlowTheme.of(context).secondary
                        : Color(0xFFF8F7FC),
                    Color(0xFFF8F7FC),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: valueOrDefault<Color>(
                      getJsonField(
                                answerListItem,
                                r'''$''',
                              ) ==
                              _model.selectedId
                          ? Color(0xFF6A55EA)
                          : Color(0xFFDFDFDF),
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
                              color: getJsonField(
                                        answerListItem,
                                        r'''$''',
                                      ) ==
                                      _model.selectedId
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
