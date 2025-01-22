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

import 'package:story_view/story_view.dart';

class CustomStoryView extends StatefulWidget {
  const CustomStoryView({
    super.key,
    this.width,
    this.height,
    required this.imageUrls,
  });

  final double? width;
  final double? height;
  final String imageUrls;

  @override
  State<CustomStoryView> createState() => _CustomStoryViewState();
}

class _CustomStoryViewState extends State<CustomStoryView> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Split the comma-separated string into a List<String>
    List<String> imageUrls = widget.imageUrls.split(',');
    // Create dynamic StoryItem list from imageUrls
    final List<StoryItem> storyItems = imageUrls.map((url) {
      return StoryItem.inlineImage(
        url: url.trim(), // Trim to handle any extra spaces
        controller: storyController,
      );
    }).toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          width: 0,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: StoryView(
        storyItems: storyItems,
        progressPosition: ProgressPosition.top,
        repeat: false,
        inline: false,
        controller: storyController,
      ),
    );
  }
}
