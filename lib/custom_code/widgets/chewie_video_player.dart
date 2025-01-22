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

import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '/flutter_flow/flutter_flow_util.dart' show routeObserver;

class ChewieVideoPlayer extends StatefulWidget {
  const ChewieVideoPlayer({
    super.key,
    this.width,
    this.height,
    required this.videoURL,
    required this.backgroundAudioTitle,
    required this.backgroundAudioArtist,
    required this.backgroundAudioArtwork,
  });

  final double? width;
  final double? height;
  final String videoURL;
  final String backgroundAudioTitle;
  final String backgroundAudioArtist;
  final String backgroundAudioArtwork;

  @override
  State<ChewieVideoPlayer> createState() => _ChewieVideoPlayerState();
}

class _ChewieVideoPlayerState extends State<ChewieVideoPlayer>
    with WidgetsBindingObserver, RouteAware {
  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  late AudioPlayer _audioPlayer;
  // late RouteObserver<PageRoute> routeObserver;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _audioPlayer = AudioPlayer();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoURL));
    _initializeVideoPlayerFuture =
        _videoPlayerController.initialize().then((_) {
      if (mounted) {
        _videoPlayerController.play();
      }
    });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
    );
    // Play in background
    _playAudioInBackground();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this); // Unsubscribe from the route observer
    _videoPlayerController.pause(); // Explicitly pause before disposing
    _videoPlayerController.dispose();
    _customVideoPlayerController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _playAudioInBackground();
    } else if (state == AppLifecycleState.resumed) {
      _resumeVideoPlayback();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to the current route
    final currentRoute = ModalRoute.of(context);
    if (currentRoute is PageRoute<dynamic>) {
      routeObserver.subscribe(this, currentRoute);
    }
  }

  @override
  void didPushNext() {
    // Called when navigating to a new screen
    _pausePlayback();
  }

  void _pausePlayback() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    }
  }

  Future<void> _playAudioInBackground() async {
    if (_videoPlayerController.value.isPlaying) {
      await _videoPlayerController.pause();
      final position = _videoPlayerController.value.position;

      // Create the audio source with a MediaItem tag
      final audioSource = AudioSource.uri(
        Uri.parse(widget.videoURL),
        tag: MediaItem(
          id: '1', // Unique ID for this media item
          album: "Album name", // Replace with actual album name
          artist: widget.backgroundAudioArtist,
          title: widget.backgroundAudioTitle, // Replace with actual song title
          artUri: Uri.parse(
              widget.backgroundAudioArtwork), // Optional album art URL
        ),
      );

      await _audioPlayer.setAudioSource(audioSource);

      await _audioPlayer.seek(position);
      // Play or pause the audio based on the parameter

      await _audioPlayer.play();
    }
  }

  Future<void> _resumeVideoPlayback() async {
    if (_audioPlayer.playing) {
      final position = _audioPlayer.position;
      await _audioPlayer.stop();
      _videoPlayerController.seekTo(position);
      _videoPlayerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: CustomVideoPlayer(
                customVideoPlayerController: _customVideoPlayerController),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
