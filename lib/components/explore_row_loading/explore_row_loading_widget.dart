import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'explore_row_loading_model.dart';
export 'explore_row_loading_model.dart';

class ExploreRowLoadingWidget extends StatefulWidget {
  const ExploreRowLoadingWidget({
    super.key,
    bool? isVertical,
  }) : isVertical = isVertical ?? false;

  final bool isVertical;

  @override
  State<ExploreRowLoadingWidget> createState() =>
      _ExploreRowLoadingWidgetState();
}

class _ExploreRowLoadingWidgetState extends State<ExploreRowLoadingWidget>
    with TickerProviderStateMixin {
  late ExploreRowLoadingModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExploreRowLoadingModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        loop: true,
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
      'containerOnPageLoadAnimation2': AnimationInfo(
        loop: true,
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
      'containerOnPageLoadAnimation3': AnimationInfo(
        loop: true,
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
          Container(
            width: valueOrDefault<double>(
              widget.isVertical ? 149.0 : 266.0,
              266.0,
            ),
            height: valueOrDefault<double>(
              widget.isVertical ? 240.0 : 150.0,
              150.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).alternate,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
          Container(
            width: valueOrDefault<double>(
              widget.isVertical ? 149.0 : 266.0,
              266.0,
            ),
            height: valueOrDefault<double>(
              widget.isVertical ? 240.0 : 150.0,
              150.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).alternate,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation2']!),
          Container(
            width: valueOrDefault<double>(
              widget.isVertical ? 149.0 : 266.0,
              266.0,
            ),
            height: valueOrDefault<double>(
              widget.isVertical ? 240.0 : 150.0,
              150.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).alternate,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation3']!),
        ].divide(const SizedBox(width: 16.0)).addToStart(const SizedBox(width: 16.0)),
      ),
    );
  }
}
