import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/features/video/components/app_video_progress_indicator.dart';
import 'package:grape_support/features/video/video_screen.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
        home: const VideoScreen(),
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
    // ネットワーク上の動画を再生する場合
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //   ),
    // );

    // 写真フォルダ内の動画を再生する場合

    // assetsフォルダ内の動画を再生する場合
    // _controller = VideoPlayerController.asset(
    //   'assets/videos/sample.mp4',
    // );
    // unawaited(
    //   _controller.initialize().then((_) {
    //     setState(() {});
    //   }),
    // );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Video Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Video Demo'),
          ),
          body: SafeArea(
            child: Center(
              // child: _controller.value.isInitialized
              child: true
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // AspectRatio(
                        //   aspectRatio: _controller.value.aspectRatio,
                        //   child: VideoPlayer(
                        //     _controller,
                        //   ),
                        // ),
                        VideoPlayer(_controller),
                        AppVideoProgressIndicator(
                          _controller,
                          padding: const EdgeInsets.only(bottom: 20),
                          allowScrubbing: true,
                          progressBarHeight: 10,
                        ),
                        Align(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? unawaited(_controller.pause())
                                    : unawaited(_controller.play());
                              });
                            },
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        final file = await _pickVideoFile();
                        if (file != null) {
                          _controller = VideoPlayerController.file(file);
                          unawaited(
                            _controller.initialize().then((_) {
                              setState(() {});
                            }),
                          );
                        }
                      },
                      child: const Text('動画を選択'),
                    ),
            ),
          ),
        ),
      );

  @override
  Future<void> dispose() async {
    super.dispose();
    await _controller.dispose();
  }

  Future<File?> _pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) {
      return null;
    }
    return File(result.files.single.path!);
  }
}
