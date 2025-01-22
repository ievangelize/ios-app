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

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '/flutter_flow/flutter_flow_util.dart' show routeObserver;

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({
    super.key,
    this.width,
    this.height,
    required this.musicUrl,
    required this.progressBarColor,
    required this.baseBarColor,
    required this.bufferedBarColor,
    required this.thumbColor,
    required this.fontSize,
    required this.fontColor,
    required this.bgAudioTItle,
    required this.bgAudioArtist,
    required this.bgAudioThumbnail,
  });

  final double? width;
  final double? height;
  final String musicUrl;
  final Color progressBarColor;
  final Color baseBarColor;
  final Color bufferedBarColor;
  final Color thumbColor;
  final double fontSize;
  final Color fontColor;
  final String bgAudioTItle;
  final String bgAudioArtist;
  final String bgAudioThumbnail;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> with RouteAware {
  var player = AudioPlayer();
  bool loaded = false;
  bool playing = false;

  void loadMusic() async {
    // Create the audio source with a MediaItem tag
    final audioSource = AudioSource.uri(
      Uri.parse(widget.musicUrl),
      tag: MediaItem(
        id: '1', // Unique ID for this media item
        album: "Album name", // Replace with actual album name
        artist: widget.bgAudioArtist,
        title: widget.bgAudioTItle, // Replace with actual song title
        artUri: Uri.parse(widget.bgAudioThumbnail), // Optional album art URL
      ),
    );

    await player.setAudioSource(audioSource);

    setState(() {
      loaded = true;
    });
  }

  void playMusic() async {
    setState(() {
      playing = true;
    });
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      playing = false;
    });
    await player.pause();
  }

  @override
  void initState() {
    loadMusic();
    super.initState();
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
    pauseMusic();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this); // Unsubscribe from the route observer
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: player.positionStream,
            builder: (context, snapshot1) {
              final Duration duration = loaded
                  ? snapshot1.data as Duration
                  : const Duration(seconds: 0);
              return StreamBuilder(
                  stream: player.bufferedPositionStream,
                  builder: (context, snapshot2) {
                    final Duration bufferedDuration = loaded
                        ? snapshot2.data as Duration
                        : const Duration(seconds: 0);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ProgressBar(
                        progress: duration,
                        total: player.duration ?? const Duration(seconds: 0),
                        buffered: bufferedDuration,
                        timeLabelPadding: -1,
                        timeLabelTextStyle: TextStyle(
                            fontSize: (widget.fontSize),
                            color: (widget.fontColor),
                            fontFamily: 'Inter'),
                        progressBarColor: (widget.progressBarColor),
                        baseBarColor: (widget.baseBarColor),
                        bufferedBarColor: (widget.bufferedBarColor),
                        thumbColor: (widget.thumbColor),
                        barHeight: 4.0,
                        thumbRadius: 6.0,
                        onSeek: loaded
                            ? (duration) async {
                                await player.seek(duration);
                              }
                            : null,
                      ),
                    );
                  });
            }),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: loaded
                      ? () async {
                          if (player.position.inSeconds >= 10) {
                            await player.seek(Duration(
                                seconds: player.position.inSeconds - 10));
                          } else {
                            await player.seek(const Duration(seconds: 0));
                          }
                        }
                      : null,
                  icon: Icon(
                    Icons.replay_10_rounded,
                    color: FlutterFlowTheme.of(context).blackWhite,
                    size: 45.0,
                  )),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FlutterFlowTheme.of(context).blackWhite),
                child: IconButton(
                    onPressed: loaded
                        ? () {
                            if (playing) {
                              pauseMusic();
                            } else {
                              playMusic();
                            }
                          }
                        : null,
                    icon: Icon(
                      playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      size: 45.0,
                    )),
              ),
              IconButton(
                  onPressed: loaded
                      ? () async {
                          if (player.position.inSeconds + 10 <=
                              player.duration!.inSeconds) {
                            await player.seek(Duration(
                                seconds: player.position.inSeconds + 10));
                          } else {
                            await player.seek(const Duration(seconds: 0));
                          }
                        }
                      : null,
                  icon: Icon(
                    Icons.forward_10_rounded,
                    color: FlutterFlowTheme.of(context).blackWhite,
                    size: 45.0,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
