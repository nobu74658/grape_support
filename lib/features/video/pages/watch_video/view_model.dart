import 'dart:async';
import 'dart:io';

import 'package:grape_support/domain/grape/domain.dart';
import 'package:grape_support/features/video/pages/watch_video/state.dart';
import 'package:grape_support/repositories/grape/repo.dart';
import 'package:grape_support/services/video_cache_service.dart';
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

    final controller = await _initializeVideo(grapeId, grape.videoUrl!);

    return VideoState(
      grape: grape,
      controller: controller,
    );
  }

  Future<VideoPlayerController> _initializeVideo(String grapeId, String videoUrl) async {
    try {
      final cacheService = ref.read(videoCacheServiceProvider.notifier);
      
      // キャッシュメタデータを読み込み
      await cacheService.loadCacheMetadata();
      
      // ローカルキャッシュから動画を取得、なければダウンロード
      final localPath = await cacheService.getVideo(grapeId, videoUrl);
      
      VideoPlayerController controller;
      
      if (localPath != null) {
        // ローカルファイルから再生
        controller = VideoPlayerController.file(File(localPath));
      } else {
        // ネットワークから再生（ダウンロード中または失敗の場合）
        controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      }

      // 動画の初期化
      await controller.initialize().then(
            (value) => controller
              ..setVolume(0)
              ..play(),
          );

      //  ViewModel破棄時に動画を破棄
      ref.onDispose(controller.dispose);

      return controller;
    } catch (e) {
      // エラーが発生した場合はネットワークから再生
      final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      
      await controller.initialize().then(
            (value) => controller
              ..setVolume(0)
              ..play(),
          );
      
      ref.onDispose(controller.dispose);
      return controller;
    }
  }
}
