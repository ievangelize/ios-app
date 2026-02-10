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

import 'package:flutter_streaming_text_markdown/flutter_streaming_text_markdown.dart';

class StreamMarkdown extends StatefulWidget {
  const StreamMarkdown({
    super.key,
    this.width,
    this.height,
    required this.airesponse, // this will be a single chunk each widget update
    this.resetOnNew =
        false, // optional: parent can set to true when you want to start fresh
  });

  final double? width;
  final double? height;
  final String airesponse;
  final bool resetOnNew;

  @override
  State<StreamMarkdown> createState() => _StreamMarkdownState();
}

class _StreamMarkdownState extends State<StreamMarkdown>
    with AutomaticKeepAliveClientMixin {
  late final StreamingTextController _controller;
  final ValueNotifier<String> _buffer = ValueNotifier<String>('');
  bool _initialized = false;
  bool _hasCalledCallback = false;

  @override
  void initState() {
    super.initState();
    _controller = StreamingTextController();
    _buffer.value = ''; // start empty or any initial text
    _controller.addListener(_onControllerChanged);
    _initialized = true;
  }

  // Called whenever parent passes a new airesponse (a chunk)
  @override
  void didUpdateWidget(covariant StreamMarkdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If parent sets resetOnNew true and airesponse differs from previous, clear buffer
    if (widget.resetOnNew && widget.airesponse != oldWidget.airesponse) {
      _buffer.value = '';
      // If controller has a reset API, call it (defensive):
      try {
        (_controller as dynamic).reset?.call();
      } catch (_) {}
    }

    // If airesponse changed, append the new delta chunk to the internal buffer
    if (widget.airesponse != oldWidget.airesponse) {
      // IMPORTANT: treat airesponse as an incremental chunk (delta).
      // Append rather than rebuild controller/widget.
      _appendChunk(widget.airesponse);
    }
  }

  void _appendChunk(String chunk) {
    // Quick guard: ignore empty or null-ish chunks
    if (chunk.isEmpty) return;

    // Append new chunk to buffer
    _buffer.value = _buffer.value + chunk;

    // If the controller exposes an append/update API, prefer calling it for better performance:
    try {
      final dyn = _controller as dynamic;
      if (dyn.append != null) {
        dyn.append(chunk); // call package-specific append if available
        return;
      }
      if (dyn.updateText != null) {
        // some controllers might expose updateText
        dyn.updateText(_buffer.value);
        return;
      }
    } catch (_) {
      // ignore: fall back to rebuilding text via ValueListenableBuilder
    }

    // else: we'll rely on ValueListenableBuilder in build() to send `text` param update.
    // No additional action required here.
  }

  void _onControllerChanged() {
    try {
      if ((_controller as dynamic).isAnimating == true && !_hasCalledCallback) {
        _hasCalledCallback = true;
        // optional callback here
      }
    } catch (_) {
      // ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: widget.width,
      child: ValueListenableBuilder<String>(
        valueListenable: _buffer,
        builder: (context, currentText, _) {
          // streaming widget uses a stable controller and just receives the latest accumulated text
          return StreamingTextMarkdown.chatGPT(
            text: currentText,
            controller: _controller,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    try {
      _controller.removeListener(_onControllerChanged);
    } catch (_) {}
    try {
      (_controller as dynamic).dispose?.call();
    } catch (_) {}
    _buffer.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
