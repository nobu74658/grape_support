import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grape_support/features/video/components/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class AssetPlayerWidget extends StatefulWidget {
  const AssetPlayerWidget({super.key});

  @override
  _AssetPlayerWidgetState createState() => _AssetPlayerWidgetState();
}

class _AssetPlayerWidgetState extends State<AssetPlayerWidget> {
  final asset = 'assets/videos/sample.mp4';
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => unawaited(controller.play()));
  }

  @override
  void dispose() {
    unawaited(controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: VideoPlayerWidget(controller: controller),
        ),
      ],
    );
  }
}
