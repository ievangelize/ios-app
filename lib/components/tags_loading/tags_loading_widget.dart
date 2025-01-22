import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'tags_loading_model.dart';
export 'tags_loading_model.dart';

class TagsLoadingWidget extends StatefulWidget {
  const TagsLoadingWidget({super.key});

  @override
  State<TagsLoadingWidget> createState() => _TagsLoadingWidgetState();
}

class _TagsLoadingWidgetState extends State<TagsLoadingWidget>
    with TickerProviderStateMixin {
  late TagsLoadingModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TagsLoadingModel());

    animationsMap.addAll({
      'choiceChipsOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).shimmer,
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: const AlignmentDirectional(-1.0, 0.0),
            child: FlutterFlowChoiceChips(
              options: [
                ChipData(FFLocalizations.of(context).getText(
                  '98otnmle' /* All */,
                )),
                ChipData(FFLocalizations.of(context).getText(
                  'le1wx1no' /* Evangelism */,
                )),
                ChipData(FFLocalizations.of(context).getText(
                  'lthzibfc' /* Podcasts */,
                )),
                ChipData(FFLocalizations.of(context).getText(
                  'b06fpc9g' /* Testimonies */,
                ))
              ],
              onChanged: (val) async {
                safeSetState(() => _model.choiceChipsValue = val?.firstOrNull);
                if (_model.choiceChipsValue != 'All') {
                  context.pushNamed(
                    'SearchResults',
                    queryParameters: {
                      'initialSearch': serializeParam(
                        _model.choiceChipsValue,
                        ParamType.String,
                      ),
                    }.withoutNulls,
                  );
                }
              },
              selectedChipStyle: ChipStyle(
                backgroundColor: FlutterFlowTheme.of(context).accent2,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).alternate,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
                iconColor: FlutterFlowTheme.of(context).info,
                iconSize: 16.0,
                labelPadding:
                    const EdgeInsetsDirectional.fromSTEB(8.0, 1.0, 8.0, 1.0),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(18.0),
              ),
              unselectedChipStyle: ChipStyle(
                backgroundColor: FlutterFlowTheme.of(context).alternate,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).alternate,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
                iconColor: FlutterFlowTheme.of(context).secondaryText,
                iconSize: 16.0,
                labelPadding:
                    const EdgeInsetsDirectional.fromSTEB(8.0, 1.0, 8.0, 1.0),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(18.0),
              ),
              chipSpacing: 8.0,
              rowSpacing: 8.0,
              multiselect: false,
              alignment: WrapAlignment.start,
              controller: _model.choiceChipsValueController ??=
                  FormFieldController<List<String>>(
                [],
              ),
              wrapped: true,
            ).animateOnPageLoad(
                animationsMap['choiceChipsOnPageLoadAnimation']!),
          ),
        ],
      ),
    );
  }
}
