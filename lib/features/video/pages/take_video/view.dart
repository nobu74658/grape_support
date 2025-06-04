import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/providers/camera/camera.dart';
import 'package:grape_support/services/video_cache_service.dart';
import 'package:video_player/video_player.dart';

class ConnectedTakeVideoScreen extends ConsumerWidget {
  const ConnectedTakeVideoScreen({required this.grapeId, super.key});

  static const path = '/take_video';
  final String grapeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraState = ref.watch(cameraProvider);

    return Scaffold(
      body: cameraState.when(
        loading: () => const CircularProgressIndicator(),
        data: (camera) => TakeVideoScreen(camera: camera, grapeId: grapeId),
        error: (err, stack) {
          debugPrint('error: $err');
          return const Placeholder();
        },
      ),
    );
  }
}

class TakeVideoScreen extends ConsumerStatefulWidget {
  const TakeVideoScreen({
    required this.camera,
    required this.grapeId,
    super.key,
  });

  final CameraDescription camera;
  final String grapeId;

  @override
  TakeVideoScreenState createState() => TakeVideoScreenState();
}

class TakeVideoScreenState extends ConsumerState<TakeVideoScreen> {
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
    }).catchError((e) {
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
          controller.value.isRecordingVideo
              ? await _stopVideo(context)
              : await _startVideo();
        },
        child: controller.value.isRecordingVideo
            ? const Icon(Icons.stop)
            : const Icon(Icons.video_call),
      ),
    );
  }

  Future<void> _startVideo() async {
    try {
      await controller.startVideoRecording();
    } on CameraException catch (e) {
      debugPrint('CameraException: $e');
      return;
    }
    setState(() {});
  }

  Future<void> _stopVideo(BuildContext context) async {
    final XFile video = await controller.stopVideoRecording();
    setState(() {});

    final File file = File(video.path);

    final String fileName =
        'grape_video_${DateTime.now().millisecondsSinceEpoch}';
    try {
      final startTime = DateTime.now();
      debugPrint('uploading video...$startTime');

      /// Firebase Storageに動画をアップロード
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('videos/${widget.grapeId}/$fileName');
      final task = await storageRef.putFile(file);
      final url = await task.ref.getDownloadURL();

      /// Firebaseに動画のURLを保存
      await FirebaseFirestore.instance
          .collection('grapes')
          .doc(widget.grapeId)
          .update({
        'videoUrl': url,
      });

      debugPrint('url: $url');
      final endTime = DateTime.now();
      debugPrint('uploaded video...$endTime');
      debugPrint('経過時間: ${endTime.difference(startTime).inMilliseconds}ms');
      debugPrint('video size: ${file.lengthSync()} bytes');

      // ローカルキャッシュにも保存
      try {
        final cacheService = ref.read(videoCacheServiceProvider.notifier);
        await cacheService.saveVideoLocally(widget.grapeId, video.path);
        debugPrint('Video saved to local cache');
      } catch (e) {
        debugPrint('Error saving to local cache: $e');
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('動画をアップロードしました')),
        );
      }
    } on Exception catch (e) {
      debugPrint('FirebaseStorageException: $e');
    }
    // 表示用の画面に遷移
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPreview(videoPath: video.path),
        fullscreenDialog: true,
      ),
    );
  }
}

// 撮影した動画を表示する画面
class VideoPreview extends StatefulWidget {
  const VideoPreview({
    required this.videoPath,
    super.key,
  });

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
