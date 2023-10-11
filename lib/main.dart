import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grape_support/components/video_progress_indicator.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const VideoApp(),
      );
}

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  VideoAppState createState() => VideoAppState();
}

class VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );
    unawaited(
      _controller.initialize().then((_) {
        setState(() {});
      }),
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Video Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Video Demo'),
          ),
          body: Center(
            child: _controller.value.isInitialized
                ? Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(
                          _controller,
                        ),
                      ),
                      PrimaryVideoProgressIndicator(
                        _controller,
                        padding: const EdgeInsets.only(top: 20),
                        allowScrubbing: true,
                        progressBarHeight: 10,
                      ),
                    ],
                  )
                : Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? unawaited(_controller.pause())
                    : unawaited(_controller.play());
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      );

  @override
  Future<void> dispose() async {
    super.dispose();
    await _controller.dispose();
  }
}
