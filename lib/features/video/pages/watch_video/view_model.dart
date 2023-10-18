import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:grape_support/features/video/pages/watch_video/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

part 'view_model.g.dart';

enum VideoSorceType {
  network,
  file,
  asset,
}

@riverpod
class VideoViewModel extends _$VideoViewModel {
  @override
  VideoState build() => const VideoState();

  Future<void> selectVideo(VideoSorceType type) async {
    state.controller?.removeListener(() {});
    // await state.controller?.dispose();
    late VideoPlayerController controller;

    switch (type) {
      case VideoSorceType.network:
        controller = VideoPlayerController.networkUrl(
          Uri.parse(
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          ),
        );
      case VideoSorceType.file:
        final result = await FilePicker.platform.pickFiles(
          type: FileType.video,
        );
        if (result == null) {
          return;
        }
        controller =
            VideoPlayerController.file(File(result.files.single.path!));
      case VideoSorceType.asset:
        controller = VideoPlayerController.asset(
          'assets/videos/sample.mp4',
        );
    }

    await controller.initialize().then((_) {});
    state = state.copyWith(controller: controller);
    unawaited(controller.play());
  }
}
