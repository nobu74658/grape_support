import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:grape_support/cache_verification.dart';
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
      
      // キャッシュメタデータを確実に読み込み
      debugPrint('🔄 Loading cache metadata...');
      await cacheService.loadCacheMetadata();
      
      // 現在のキャッシュ状態をログ出力
      final currentState = ref.read(videoCacheServiceProvider);
      debugPrint('📊 Current cache state entries: ${currentState.length}');
      
      // ローカルキャッシュから動画を取得、なければダウンロード
      debugPrint('🔍 Checking cache for grapeId: $grapeId');
      final localPath = await cacheService.getVideo(grapeId, videoUrl);
      
      VideoPlayerController controller;
      
      if (localPath != null) {
        // ローカルファイルの存在を再確認
        final file = File(localPath);
        if (file.existsSync()) {
          final fileStat = file.statSync();
          debugPrint('🎬 Playing video from local cache: $localPath (${(fileStat.size / (1024 * 1024)).toStringAsFixed(2)}MB)');
          controller = VideoPlayerController.file(file);
        } else {
          debugPrint('⚠️ Local file not found, falling back to network: $localPath');
          controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
        }
      } else {
        // ネットワークから再生（ダウンロード中または失敗の場合）
        debugPrint('🌐 Playing video from network: $videoUrl');
        controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      }

      // 動画の初期化
      debugPrint('⚙️ Initializing video controller...');
      await controller.initialize().then(
            (value) => controller
              ..setVolume(0)
              ..play(),
          );
      debugPrint('✅ Video controller initialized successfully');
      
      // キャッシュ状態を再確認
      debugPrint('🔍 Verifying if video is cached after initialization...');
      await CacheVerification.isFileCached(grapeId);

      //  ViewModel破棄時に動画を破棄
      ref.onDispose(controller.dispose);

      return controller;
    } on Exception catch (e) {
      debugPrint('❌ Error in video initialization: $e');
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
