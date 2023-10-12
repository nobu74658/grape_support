import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grape_support/features/video/components/app_video_progress_indicator.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatelessWidget {
  const BasicOverlayWidget({
    required this.controller,
    super.key,
  });
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.value.isPlaying
            ? unawaited(controller.pause())
            : unawaited(controller.play()),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            ),
          ],
        ),
      );

  Widget buildIndicator() => AppVideoProgressIndicator(
        controller,
        progressBarHeight: 20,
        allowScrubbing: true,
      );
}
