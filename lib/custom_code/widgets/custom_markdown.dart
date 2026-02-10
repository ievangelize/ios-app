// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class CustomMarkdown extends StatefulWidget {
  const CustomMarkdown({
    super.key,
    this.width,
    this.height,
    required this.fontSize,
    required this.textColor,
    required this.blockquoteBackground,
    required this.blockquoteTextColor,
    required this.data,
  });

  final double? width;
  final double? height;
  final double fontSize;
  final Color textColor;
  final Color blockquoteBackground;
  final Color blockquoteTextColor;
  final String data;

  @override
  State<CustomMarkdown> createState() => _CustomMarkdownState();
}

class _CustomMarkdownState extends State<CustomMarkdown> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextStyle base = theme.textTheme.bodyMedium ?? const TextStyle();

    final paragraphStyle = base.copyWith(
        fontSize: widget.fontSize,
        fontFamily: 'Inter',
        color: widget.textColor);

    final blockquoteStyle = paragraphStyle.copyWith(
      color: widget.blockquoteTextColor,
    );

    final styleSheet = MarkdownStyleSheet.fromTheme(theme).copyWith(
      p: paragraphStyle,
      blockquote: blockquoteStyle,

      /// No padding / radius overrides → uses built-in defaults
      blockquoteDecoration: BoxDecoration(
        color: widget.blockquoteBackground,
      ),
    );

    return MarkdownBody(
      data: widget.data,
      styleSheet: styleSheet,
    );
  }
}
