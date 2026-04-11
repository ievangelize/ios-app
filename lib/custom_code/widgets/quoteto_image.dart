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

import 'dart:io';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QuotetoImage extends StatefulWidget {
  const QuotetoImage({
    super.key,
    this.width,
    this.height,
    this.quoteWidget,
  });

  final double? width;
  final double? height;
  final Widget Function()? quoteWidget;

  @override
  State<QuotetoImage> createState() => _QuotetoImageState();
}

class _QuotetoImageState extends State<QuotetoImage> {
  final WidgetsToImageController _controller = WidgetsToImageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _capture() async {
    try {
      // Give iOS time to render
      await Future.delayed(const Duration(milliseconds: 100));

      final pngBytes =
          await _controller.capturePng(pixelRatio: 2.0); // safer for iOS

      if (pngBytes == null || pngBytes.isEmpty) {
        debugPrint("PNG capture returned null/empty on iOS");
        return;
      }

      final ts = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'quote_$ts.png';

      // Write temp file (more reliable on iOS)
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)]);
    } catch (e, st) {
      debugPrint('Error capturing/sharing image: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:
          Alignment.bottomCenter, // centers horizontally, sticks to bottom
      children: [
        // Main content (fills available space)
        Positioned.fill(
          child: WidgetsToImage(
            controller: _controller,
            child: widget.quoteWidget?.call() ?? const SizedBox.shrink(),
          ),
        ),

        // Bottom-centered button
        Positioned(
          left: 16,
          right: 16,
          bottom: 16, // SafeArea handles the bottom inset
          child: SafeArea(
            minimum: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: 54,
              child: TextButton(
                onPressed: _capture,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.zero, // ensures consistent height
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  overlayColor: Colors.transparent, // removes ripple
                ),
                child: const Text(
                  'SHARE QUOTE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500, // Medium
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
