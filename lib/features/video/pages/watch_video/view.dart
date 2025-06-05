import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/domain/grape/domain.dart';
import 'package:grape_support/features/video/components/video_player_widget.dart';
import 'package:grape_support/features/video/pages/watch_video/view_model.dart';
import 'package:grape_support/models/video_cache_model.dart';
import 'package:grape_support/primary/primary_when_widget.dart';
import 'package:grape_support/services/video_cache_service.dart';

class WatchVideoScreen extends ConsumerWidget {
  const WatchVideoScreen({
    required this.videoUrl,
    super.key,
  });

  static const path = '/watch-video';

  final String videoUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoViewModelProvider(videoUrl));

    return state.when(
      error: (err, stack) => PrimaryWhenWidget(
        whenType: WhenType.error,
        errorMessage: err.toString(),
      ),
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const PrimaryWhenWidget(whenType: WhenType.loading),
      ),
      data: (data) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            // ダウンロード制御ボタン
            _buildDownloadControlButton(ref, data.grape),
            // キャッシュ状態を表示するインジケーター
            _buildCacheStatusIndicator(ref, data.grape.grapeId),
          ],
        ),
        body: Stack(
          children: [
            VideoPlayerWidget(controller: data.controller),
            // キャッシュ状態を表示するオーバーレイ
            _buildCacheStatusOverlay(ref, data.grape.grapeId),
          ],
        ),
      ),
    );
  }

  /// キャッシュ状態を表示するインジケーター
  Widget _buildCacheStatusIndicator(WidgetRef ref, String grapeId) {
    final cacheState = ref.watch(videoCacheServiceProvider);
    final cacheModel = cacheState[grapeId];

    if (cacheModel == null) {
      return const Icon(Icons.cloud_outlined, color: Colors.grey);
    }

    switch (cacheModel.status) {
      case CacheStatus.cached:
        return const Tooltip(
          message: 'ローカル保存済み',
          child: Icon(Icons.offline_pin, color: Colors.green),
        );
      case CacheStatus.downloading:
        return Tooltip(
          message:
              'ダウンロード中: ${(cacheModel.downloadProgress ?? 0 * 100).toStringAsFixed(0)}%',
          child: const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      case CacheStatus.error:
        return const Tooltip(
          message: 'キャッシュエラー',
          child: Icon(Icons.error_outline, color: Colors.red),
        );
      case CacheStatus.notCached:
        return const Tooltip(
          message: 'ネットワーク再生',
          child: Icon(Icons.cloud_outlined, color: Colors.grey),
        );
    }
  }

  /// キャッシュ状態を表示するオーバーレイ
  Widget _buildCacheStatusOverlay(WidgetRef ref, String grapeId) {
    final cacheState = ref.watch(videoCacheServiceProvider);
    final cacheModel = cacheState[grapeId];

    // キャッシュ状態がない場合は何も表示しない
    if (cacheModel == null) {
      return const SizedBox.shrink();
    }

    // キャッシュ済みの場合は「オフライン再生」バッジを表示
    if (cacheModel.status == CacheStatus.cached) {
      return Positioned(
        top: 16,
        right: 16,
        child: _buildOfflineBadge(),
      );
    }

    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: _buildCacheStatusCard(cacheModel),
    );
  }

  /// キャッシュ状態カードを構築
  Widget _buildCacheStatusCard(VideoCacheModel cacheModel) {
    String message;
    IconData icon;
    Color backgroundColor;
    Widget? trailing;

    switch (cacheModel.status) {
      case CacheStatus.downloading:
        final progress = (cacheModel.downloadProgress ?? 0) * 100;
        message = 'オフライン再生用にダウンロード中...';
        icon = Icons.download;
        backgroundColor = Colors.blue.withOpacity(0.9);
        trailing = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              value: cacheModel.downloadProgress,
              backgroundColor: Colors.white30,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
            const SizedBox(height: 4),
            Text(
              '${progress.toStringAsFixed(0)}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      case CacheStatus.error:
        message = 'ダウンロードに失敗しました\nネットワーク再生中...';
        icon = Icons.warning;
        backgroundColor = Colors.orange.withOpacity(0.9);
        trailing = null;
      case CacheStatus.notCached:
        message = 'ネットワーク再生中...';
        icon = Icons.cloud_outlined;
        backgroundColor = Colors.grey.withOpacity(0.9);
        trailing = null;
      case CacheStatus.cached:
        return const SizedBox.shrink(); // キャッシュ済みの場合は表示しない
    }

    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing,
            ],
          ],
        ),
      ),
    );
  }

  /// オフライン再生バッジを構築
  Widget _buildOfflineBadge() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.offline_pin,
              color: Colors.white,
              size: 16,
            ),
            SizedBox(width: 4),
            Text(
              'オフライン再生',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  /// ダウンロード制御ボタンを構築
  Widget _buildDownloadControlButton(WidgetRef ref, Grape grape) {
    if (grape.videoUrl == null) {
      return const SizedBox.shrink();
    }

    final cacheState = ref.watch(videoCacheServiceProvider);
    final cacheModel = cacheState[grape.grapeId];
    final cacheService = ref.read(videoCacheServiceProvider.notifier);

    switch (cacheModel?.status) {
      case CacheStatus.cached:
        // 既にキャッシュされている場合は削除ボタン
        return IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () async {
            await cacheService.deleteCache(grape.grapeId);
            if (ref.context.mounted) {
              ScaffoldMessenger.of(ref.context).showSnackBar(
                const SnackBar(content: Text('キャッシュを削除しました')),
              );
            }
          },
          tooltip: 'キャッシュを削除',
        );

      case CacheStatus.downloading:
        // ダウンロード中の場合はキャンセルボタン
        return IconButton(
          icon: const Icon(Icons.close),
          onPressed: () async {
            await cacheService.cancelDownload(grape.grapeId);
            if (ref.context.mounted) {
              ScaffoldMessenger.of(ref.context).showSnackBar(
                const SnackBar(content: Text('ダウンロードをキャンセルしました')),
              );
            }
          },
          tooltip: 'ダウンロードをキャンセル',
        );

      case CacheStatus.error:
      case CacheStatus.notCached:
      case null:
        // キャッシュされていない場合はダウンロードボタン
        return IconButton(
          icon: const Icon(Icons.download),
          onPressed: () async {
            await cacheService.downloadVideoManually(
              grape.grapeId,
              grape.videoUrl!,
            );
            if (ref.context.mounted) {
              ScaffoldMessenger.of(ref.context).showSnackBar(
                const SnackBar(content: Text('ダウンロードを開始しました')),
              );
            }
          },
          tooltip: 'オフライン再生用にダウンロード',
        );
    }
  }
}
