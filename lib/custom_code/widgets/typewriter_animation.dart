// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:typewritertext/typewritertext.dart';

class TypewriterAnimation extends StatefulWidget {
  const TypewriterAnimation({
    super.key,
    this.width,
    this.height,
    required this.fontSize,
    required this.fontColor,
    required this.textSpeed,
    required this.text,
  });

  final double? width;
  final double? height;
  final double fontSize;
  final Color fontColor;
  final int textSpeed;
  final String text;

  @override
  State<TypewriterAnimation> createState() => _TypewriterAnimationState();
}

class _TypewriterAnimationState extends State<TypewriterAnimation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeWriter.text(
          widget.text,
          maintainSize: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: widget.fontSize, // Remove const as it is dynamic
            fontWeight: FontWeight.bold,
            color: widget.fontColor,
            fontFamily: 'Inter',
          ),
          duration: Duration(milliseconds: widget.textSpeed), // Remove const
        ),
      ],
    );
  }
}
