// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_streaming_text_markdown/flutter_streaming_text_markdown.dart';

class StreamingMarkdownText extends StatefulWidget {
  const StreamingMarkdownText({
    super.key,
    this.width,
    this.height,
    required this.text,
    this.fontSize = 16,
    this.textColor = Colors.black87,
    this.markdownFontSize = 16,
    this.markdownColor = Colors.black87,
    this.backgroundColor,
  });

  final double? width;
  final double? height;
  final String text;
  final double fontSize;
  final Color textColor;
  final double markdownFontSize;
  final Color markdownColor;
  final Color? backgroundColor;

  @override
  State<StreamingMarkdownText> createState() => _StreamingMarkdownTextState();
}

class _StreamingMarkdownTextState extends State<StreamingMarkdownText> {
  @override
  Widget build(BuildContext context) {
    final theme = StreamingTextTheme(
      textStyle: TextStyle(
        fontSize: widget.fontSize,
        color: widget.textColor,
      ),
      markdownStyleSheet: TextStyle(
        fontSize: widget.markdownFontSize,
        fontWeight: FontWeight.w400,
        color: widget.markdownColor,
      ),
      defaultPadding: const EdgeInsets.all(16),
    );

    return Container(
      color: widget.backgroundColor,
      child: StreamingTextMarkdown.claude(
        text: widget.text,
        theme: theme,
      ),
    );
  }
}
