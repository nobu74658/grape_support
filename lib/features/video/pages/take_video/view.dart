import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class TakeVideoScreen extends StatefulWidget {
  const TakeVideoScreen({
    required this.camera,
    super.key,
  });

  static const path = '/take_video';

  final CameraDescription camera;

  @override
  TakeVideoScreenState createState() => TakeVideoScreenState();
}

class TakeVideoScreenState extends State<TakeVideoScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('動画撮影')),
      body: CameraPreview(controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await controller.startVideoRecording();
          } on CameraException catch (e) {
            debugPrint('CameraException: $e');
            return;
          }
          await Future.delayed(const Duration(seconds: 5));

          final video = await controller.stopVideoRecording();

          // 表示用の画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VideoPreview(videoPath: video.path),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}

// 撮影した動画を表示する画面
class VideoPreview extends StatefulWidget {
  const VideoPreview({
    Key? key,
    required this.videoPath,
  }) : super(key: key);

  final String videoPath;

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath));
    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
