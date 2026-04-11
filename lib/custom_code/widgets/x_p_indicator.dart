// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:step_progress_indicator/step_progress_indicator.dart';

class XPIndicator extends StatefulWidget {
  const XPIndicator({
    super.key,
    this.width,
    this.height,
    required this.currentXp,
    required this.levelMinXp,
    required this.levelMaxXp,
    required this.selectedColor,
    required this.unselectedColor,
    required this.size,
    required this.padding,
  });

  final double? width;
  final double? height;
  final int currentXp;
  final int levelMinXp;
  final int levelMaxXp;
  final Color selectedColor;
  final Color unselectedColor;
  final double size;
  final double padding;

  @override
  State<XPIndicator> createState() => _XPIndicatorState();
}

class _XPIndicatorState extends State<XPIndicator> {
  static const int _totalSteps = 60;

  int _computeCurrentStep() {
    final double min = widget.levelMinXp.toDouble();
    final double max = widget.levelMaxXp.toDouble();
    final double span = max - min;

    // Guard: if misconfigured (span <= 0), show full bar
    if (span <= 0) return _totalSteps;

    // Map currentXp into this level’s span
    final double rawProgress = (widget.currentXp.toDouble() - min) / span;

    // Clamp to [0,1]
    final double progress = rawProgress.clamp(0.0, 1.0);

    // Convert to step count
    return (progress * _totalSteps).round();
  }

  @override
  Widget build(BuildContext context) {
    final int currentStep = _computeCurrentStep();
    return Container(
      child: StepProgressIndicator(
        totalSteps: _totalSteps,
        currentStep: currentStep,
        size: widget.size,
        padding: widget.padding,
        selectedColor: widget.selectedColor,
        unselectedColor: widget.unselectedColor,
      ),
    );
  }
}
