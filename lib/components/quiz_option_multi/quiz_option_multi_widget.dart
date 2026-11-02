import '/backend/supabase/supabase.dart';
import '/components/check_answer_correct/check_answer_correct_widget.dart';
import '/components/check_answer_incorrect/check_answer_incorrect_widget.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_option_multi_model.dart';
export 'quiz_option_multi_model.dart';

class QuizOptionMultiWidget extends StatefulWidget {
  const QuizOptionMultiWidget({
    super.key,
    this.supabaseOptionsList,
    required this.quizFeedback,
    required this.swipeStack,
  });

  final List<QuizOptionsRow>? supabaseOptionsList;
  final String? quizFeedback;
  final Future Function()? swipeStack;

  @override
  State<QuizOptionMultiWidget> createState() => _QuizOptionMultiWidgetState();
}

class _QuizOptionMultiWidgetState extends State<QuizOptionMultiWidget> {
  late QuizOptionMultiModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizOptionMultiModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      for (int loop1Index = 0;
          loop1Index <
              widget.supabaseOptionsList!
                  .where((e) => e.isCorrect!)
                  .toList()
                  .length;
          loop1Index++) {
        final currentLoop1Item = widget.supabaseOptionsList!
            .where((e) => e.isCorrect!)
            .toList()[loop1Index];
        _model.addToCorrectOptionIds(currentLoop1Item.id!);
        safeSetState(() {});
      }
    });
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 35.0),
          child: Builder(
            builder: (context) {
              final optionsList = widget.supabaseOptionsList?.toList() ?? [];

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(optionsList.length, (optionsListIndex) {
                  final optionsListItem = optionsList[optionsListIndex];
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.addToSelectedOptionIds(optionsListItem.id!);
                      safeSetState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: 52.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).accent2,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: valueOrDefault<Color>(
                            () {
                              if (_model.selectedOptionIds
                                  .contains(optionsListItem.id)) {
                                return FlutterFlowTheme.of(context).secondary;
                              } else if (_model.correctOptionIds
                                      .contains(optionsListItem.id) &&
                                  (_model.checkedAnswer == true)) {
                                return Color(0xFF5C9342);
                              } else if (_model.selectedOptionIds
                                      .contains(optionsListItem.id) &&
                                  !_model.correctOptionIds
                                      .contains(optionsListItem.id) &&
                                  (_model.checkedAnswer == true)) {
                                return Color(0xFFF13A28);
                              } else {
                                return FlutterFlowTheme.of(context).dfdfdf;
                              }
                            }(),
                            FlutterFlowTheme.of(context).dfdfdf,
                          ),
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 8.0, 12.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                valueOrDefault<String>(
                                  optionsListItem.optionText,
                                  'It instantly vanishes.',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            if (_model.correctOptionIds
                                    .contains(optionsListItem.id) &&
                                (_model.checkedAnswer == true))
                              FaIcon(
                                FaIconData(const IconData(
                                    /* solidCheckCircle */ 0xf058,
                                    fontFamily: 'FontAwesomeSolid',
                                    fontPackage: 'font_awesome_flutter')),
                                color: valueOrDefault<Color>(
                                  _model.correctOptionIds
                                              .contains(optionsListItem.id) &&
                                          (_model.checkedAnswer == true)
                                      ? Color(0xFF5C9342)
                                      : (_model.selectedOptionIds.contains(
                                                  optionsListItem.id) &&
                                              !_model.correctOptionIds.contains(
                                                  optionsListItem.id) &&
                                              (_model.checkedAnswer == true)
                                          ? Color(0xFFF13A28)
                                          : Color(0x00000000)),
                                  Color(0xFFDFDFDF),
                                ),
                                size: 18.0,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).divide(SizedBox(height: 10.0)),
              );
            },
          ),
        ),
        wrapWithModel(
          model: _model.largeBtnModel,
          updateCallback: () => safeSetState(() {}),
          child: LargeBtnWidget(
            text: 'Check Asnwer',
            color: FlutterFlowTheme.of(context).secondary,
            textColor: FlutterFlowTheme.of(context).info,
            action: () async {
              _model.checkedAnswer = true;
              safeSetState(() {});
              if (_model.selectedOptionIds
                      .toSet()
                      .containsAll(_model.correctOptionIds.toSet()) &&
                  _model.correctOptionIds
                      .toSet()
                      .containsAll(_model.selectedOptionIds.toSet())) {
                await Future.delayed(
                  Duration(
                    milliseconds: 100,
                  ),
                );
                for (int loop1Index = 0;
                    loop1Index < _model.haptics.length;
                    loop1Index++) {
                  final currentLoop1Item = _model.haptics[loop1Index];
                  HapticFeedback.mediumImpact();
                  await Future.delayed(
                    Duration(
                      milliseconds: currentLoop1Item,
                    ),
                  );
                }
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  isDismissible: false,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: CheckAnswerCorrectWidget(
                        feedback: widget.quizFeedback!,
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              } else {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  isDismissible: false,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: CheckAnswerIncorrectWidget(
                        feedback: widget.quizFeedback!,
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              }

              await widget.swipeStack?.call();
            },
          ),
        ),
      ],
    );
  }
}
