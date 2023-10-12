import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grape_support/features/video/components/app_video_progress_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  const VideoTile({
    required this.controller,
    super.key,
  });
  final VideoPlayerController controller;

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoPlayer(widget.controller),
          AppVideoProgressIndicator(
            widget.controller,
            padding: const EdgeInsets.only(bottom: 40),
            allowScrubbing: true,
            progressBarHeight: 10,
          ),
          Align(
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget.controller.value.isPlaying
                      ? unawaited(widget.controller.pause())
                      : unawaited(widget.controller.play());
                });
              },
              icon: Icon(
                widget.controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      );
}
