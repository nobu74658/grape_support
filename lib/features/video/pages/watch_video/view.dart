import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grape_support/features/video/components/floating_action_button_widget.dart';
import 'package:grape_support/features/video/components/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  final textController = TextEditingController(
    text: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  );
  VideoPlayerController? controller;

  @override
  void dispose() {
    unawaited(controller?.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: (controller == null)
            ? buildTextField()
            : GestureDetector(
                onTap: () => primaryFocus?.unfocus(),
                child: ListView(
                  children: [
                    buildTextField(),
                    VideoPlayerWidget(controller: controller!),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButtonWidget(
          onPressed: () async {
            await initializeVideo();
          },
        ),
      );

  Widget buildTextField() => Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      );

  Future<void> initializeVideo() async {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(textController.text.trim()),
    );
    unawaited(
      controller.initialize().then((_) {
        controller
          ..setVolume(0)
          ..play();
        setState(() => this.controller = controller);
      }),
    );
  }
}
