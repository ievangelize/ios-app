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

import 'dart:async';
import 'package:video_player/video_player.dart';

class CustomVidPlayer extends StatefulWidget {
  const CustomVidPlayer({
    super.key,
    this.width,
    this.height,
    required this.videoPath,
  });

  final double? width;
  final double? height;
  final String videoPath;

  @override
  State<CustomVidPlayer> createState() => _CustomVidPlayerState();
}

class _CustomVidPlayerState extends State<CustomVidPlayer> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  late Timer _progressTimer;
  double _progress = 0.0;

  void _startProgressTimer() {
    _progressTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_videoPlayerController.value.isInitialized) {
        setState(() {
          _progress = _videoPlayerController.value.position.inMilliseconds /
              _videoPlayerController.value.duration.inMilliseconds;
        });
      }
    });
  }

  void _onSeek(double newValue) {
    final newPosition = Duration(
      milliseconds:
          (_videoPlayerController.value.duration.inMilliseconds * newValue)
              .toInt(),
    );
    _videoPlayerController.seekTo(newPosition);
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoPath))
          ..setLooping(true);
    _initializeVideoPlayerFuture =
        _videoPlayerController.initialize().then((_) {
      if (mounted) {
        _startProgressTimer(); // Start progress updates
        _videoPlayerController.play(); // AutoPlay
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _progressTimer.cancel(); // Cancel timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // _videoPlayerController.play();
          return Stack(
            children: [
              // Expanded content to occupy the main area of the screen
              Positioned.fill(
                child: GestureDetector(
                  onTap: toggleVideoPlayback, // Toggle play/pause on tap
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.black, // Background color for uncovered areas
                    child: FittedBox(
                      fit: BoxFit
                          .cover, // Ensures the video covers the area while maintaining aspect ratio
                      child: SizedBox(
                        width: _videoPlayerController.value.size.width,
                        height: _videoPlayerController.value.size.height,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    ),
                  ),
                ),
              ),
              // Slider aligned at the bottom center
              Align(
                alignment: Alignment
                    .bottomCenter, // Align the column at the bottom center
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Make the column shrink-wrap its content
                  children: [
                    SafeArea(
                      // bottom: true, // Apply safe area padding only at the top
                      child: Container(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4.0,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 6.0),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 10.0),
                            thumbColor: Color.fromARGB(
                                255, 106, 85, 234), // Customize thumb color
                            activeTrackColor: const Color.fromARGB(255, 106, 85,
                                234), // Customize active track color
                            inactiveTrackColor: const Color.fromARGB(51, 158,
                                158, 158), // Customize inactive track color
                          ),
                          child: Slider(
                            value: _progress,
                            min: 0.0,
                            max: 1.0,
                            onChanged: (newValue) {
                              setState(() {
                                _progress = newValue;
                              });
                            },
                            onChangeEnd: _onSeek,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void toggleVideoPlayback() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
  }
}
