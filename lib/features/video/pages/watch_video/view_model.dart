import 'dart:async';

import 'package:grape_support/domain/grape/domain.dart';
import 'package:grape_support/features/video/pages/watch_video/state.dart';
import 'package:grape_support/repositories/grape/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

part 'view_model.g.dart';

@riverpod
class VideoViewModel extends _$VideoViewModel {
  @override
  Future<VideoState> build(String grapeId) async {
    final repo = ref.read(grapeRepoProvider.notifier);
    final Grape grape = await repo.getDoc(grapeId);

    // videoUrl が null の場合はエラーを投げる
    if (grape.videoUrl == null) {
      throw Exception('No video url');
    }

    final controller = await initializeVideo(grape.videoUrl!);

    return VideoState(
      grape: grape,
      controller: controller,
    );
  }

  Future<VideoPlayerController> initializeVideo(String videoUrl) async {
    // videoUrl で動画を取得する
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    );

    // 動画の初期化
    await controller.initialize().then(
          (value) => controller
            ..setVolume(0)
            ..play(),
        );

    //  ViewModel破棄時に動画を破棄
    ref.onDispose(controller.dispose);

    return controller;
  }
}
