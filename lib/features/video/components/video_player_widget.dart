import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grape_support/features/video/components/app_video_progress_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({
    required this.controller,
    super.key,
  });
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.value.isPlaying
            ? unawaited(controller.pause())
            : unawaited(controller.play()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),
            const Spacer(),
            AppVideoProgressIndicator(
              controller,
              progressBarHeight: 20,
              allowScrubbing: true,
            ),
          ],
        ),
      ),
    );
  }
}
