import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/domain/grape/domain.dart';
import 'package:grape_support/features/app/grapes_state.dart';
import 'package:grape_support/features/grape/pages/grape_details/view.dart';
import 'package:grape_support/models/video_cache_model.dart';
import 'package:grape_support/services/video_cache_service.dart';
import 'package:intl/intl.dart';

class ConnectedGrapeListPage extends ConsumerWidget {
  const ConnectedGrapeListPage({super.key});

  static const path = '/grapes';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(grapesStateProvider);

    // 一覧画面表示時にキャッシュメタデータを確実に読み込み（初回のみ）
    ref.listen(grapesStateProvider, (previous, next) async {
      if (previous is! AsyncData && next is AsyncData) {
        await _ensureCacheMetadataLoaded(ref);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('一覧'),
      ),
      body: state.when(
        error: (err, stackTrace) =>
            const Scaffold(body: Center(child: Text('Error: err'))),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        data: (data) => Column(
          children: [
            // キャッシュ統計ヘッダー
            _buildCacheStatsHeader(ref, data),
            // グレープリスト
            Expanded(child: GrapeListPage(grapes: data)),
          ],
        ),
      ),
    );
  }

  /// キャッシュメタデータの読み込みを確実に実行
  Future<void> _ensureCacheMetadataLoaded(WidgetRef ref) async {
    try {
      final cacheService = ref.read(videoCacheServiceProvider.notifier);
      await cacheService.loadCacheMetadata();
      debugPrint('🔄 Cache metadata loaded on grape list state change');
    } on Exception catch (e) {
      debugPrint('❌ Failed to reload cache metadata: $e');
    }
  }

  /// キャッシュ統計ヘッダーを構築
  Widget _buildCacheStatsHeader(WidgetRef ref, List<Grape> grapes) {
    final cacheState = ref.watch(videoCacheServiceProvider);

    final videosWithUrl =
        grapes.where((grape) => grape.videoUrl != null).toList();
    final cachedCount = videosWithUrl.where((grape) {
      final cacheModel = cacheState[grape.grapeId];
      return cacheModel?.status == CacheStatus.cached;
    }).length;

    final downloadingCount = videosWithUrl.where((grape) {
      final cacheModel = cacheState[grape.grapeId];
      return cacheModel?.status == CacheStatus.downloading;
    }).length;

    if (videosWithUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[50],
      child: Row(
        children: [
          Icon(Icons.video_library_outlined, size: 18, color: Colors.grey[600]),
          const Gap(8),
          Text(
            '動画: ${videosWithUrl.length}件',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const Gap(16),
          if (cachedCount > 0) ...[
            const Icon(Icons.offline_pin, size: 16, color: Colors.green),
            const Gap(4),
            Text(
              'オフライン: $cachedCount件',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (downloadingCount > 0) ...[
            const Gap(16),
            const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            const Gap(4),
            Text(
              'DL中: $downloadingCount件',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ],
          const Spacer(),
          // 一括ダウンロードボタン
          _buildBulkDownloadButton(ref, grapes),
        ],
      ),
    );
  }

  /// 一括ダウンロードボタンを構築
  Widget _buildBulkDownloadButton(WidgetRef ref, List<Grape> grapes) {
    final cacheState = ref.watch(videoCacheServiceProvider);
    final cacheService = ref.read(videoCacheServiceProvider.notifier);

    final videosWithUrl =
        grapes.where((grape) => grape.videoUrl != null).toList();
    final uncachedVideos = videosWithUrl.where((grape) {
      final cacheModel = cacheState[grape.grapeId];
      return cacheModel?.status != CacheStatus.cached;
    }).toList();

    if (uncachedVideos.isEmpty) {
      return const SizedBox.shrink();
    }

    return TextButton.icon(
      onPressed: () async {
        // 一括ダウンロード実行
        for (final grape in uncachedVideos) {
          if (grape.videoUrl != null) {
            final cacheModel = cacheState[grape.grapeId];
            // ダウンロード中でない場合のみ開始
            if (cacheModel?.status != CacheStatus.downloading) {
              await cacheService.downloadVideoManually(
                grape.grapeId,
                grape.videoUrl!,
              );
            }
          }
        }
      },
      icon: const Icon(Icons.download_for_offline, size: 16),
      label: Text(
        '${uncachedVideos.length}件DL',
        style: const TextStyle(fontSize: 12),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

class GrapeListPage extends ConsumerWidget {
  const GrapeListPage({required this.grapes, super.key});

  final List<Grape> grapes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 初回表示時にキャッシュメタデータを確認
    final cacheState = ref.watch(videoCacheServiceProvider);
    if (cacheState.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          final cacheService = ref.read(videoCacheServiceProvider.notifier);
          await cacheService.loadCacheMetadata();
          debugPrint('🔄 Cache metadata loaded for grape list items');
        } on Exception catch (e) {
          debugPrint('❌ Failed to load cache metadata for list: $e');
        }
      });
    }

    return Scaffold(
      body: CustomMaterialIndicator(
        trigger: IndicatorTrigger.trailingEdge,
        onRefresh: () async {
          final state = ref.read(grapesStateProvider.notifier);
          await state.loadMore();
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          itemCount: grapes.length + 1,
          itemBuilder: (context, index) {
            if (index == grapes.length) {
              return Align(
                child: TextButton(
                  onPressed: () async {
                    final state = ref.read(grapesStateProvider.notifier);
                    await state.loadMore();
                  },
                  child: const Text('もっと見る'),
                ),
              );
            }

            final grape = grapes[index];
            final format = DateFormat('yyyy/MM/dd HH:mm');
            final date = format.format(grape.createdAt);

            final decoration = _getListItemDecoration(ref, grape);

            final listTile = ListTile(
              title: Text(grape.grapeId),
              subtitle: grape.videoUrl != null
                  ? _buildVideoSubtitle(ref, grape.grapeId)
                  : null,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (grape.videoUrl != null) ...[
                    const Icon(Icons.video_collection_sharp),
                    const Gap(4),
                    // キャッシュ状態インジケーター
                    _buildCacheStatusIcon(ref, grape.grapeId),
                    const Gap(8),
                    // ダウンロードボタン
                    _buildDownloadButton(ref, grape),
                    const Gap(16),
                  ],
                  Text(date),
                ],
              ),
              onTap: () async =>
                  context.push('${GrapeDetailsPage.path}/${grape.grapeId}'),
            );

            return decoration != null
                ? DecoratedBox(
                    decoration: decoration,
                    child: listTile,
                  )
                : listTile;
          },
        ),
      ),
    );
  }

  /// リストアイテムの装飾を取得
  BoxDecoration? _getListItemDecoration(WidgetRef ref, Grape grape) {
    if (grape.videoUrl == null) {
      return null;
    }

    final cacheState = ref.watch(videoCacheServiceProvider);
    final cacheModel = cacheState[grape.grapeId];

    if (cacheModel?.status == CacheStatus.cached) {
      return BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.green.withOpacity(0.6),
            width: 4,
          ),
        ),
      );
    }

    return null;
  }

  /// 動画のサブタイトルを構築
  Widget _buildVideoSubtitle(WidgetRef ref, String grapeId) {
    final cacheState = ref.watch(videoCacheServiceProvider);
    final cacheModel = cacheState[grapeId];

    if (cacheModel == null) {
      return const Text(
        '動画あり',
        style: TextStyle(fontSize: 12, color: Colors.grey),
      );
    }

    String statusText;
    Color statusColor;

    switch (cacheModel.status) {
      case CacheStatus.cached:
        final sizeText = cacheModel.fileSizeBytes != null
            ? ' (${(cacheModel.fileSizeBytes! / (1024 * 1024)).toStringAsFixed(1)}MB)'
            : '';
        statusText = 'オフライン再生可能$sizeText';
        statusColor = Colors.green;
      case CacheStatus.downloading:
        final progress = (cacheModel.downloadProgress ?? 0) * 100;
        statusText = 'ダウンロード中 ${progress.toStringAsFixed(0)}%';
        statusColor = Colors.blue;
      case CacheStatus.error:
        statusText = 'ダウンロードエラー';
        statusColor = Colors.orange;
      case CacheStatus.notCached:
        statusText = 'ネットワーク再生のみ';
        statusColor = Colors.grey;
    }

    return Text(
      statusText,
      style: TextStyle(
        fontSize: 12,
        color: statusColor,
        fontWeight: cacheModel.status == CacheStatus.cached
            ? FontWeight.w600
            : FontWeight.normal,
      ),
    );
  }

  /// キャッシュ状態アイコンを構築
  Widget _buildCacheStatusIcon(WidgetRef ref, String grapeId) {
    final cacheState = ref.watch(videoCacheServiceProvider);
    final cacheModel = cacheState[grapeId];

    if (cacheModel == null) {
      return const SizedBox(width: 20);
    }

    Widget icon;
    Color? color;
    String tooltip;

    switch (cacheModel.status) {
      case CacheStatus.cached:
        icon = const Icon(Icons.offline_pin, size: 18);
        color = Colors.green;
        tooltip = 'ローカル保存済み';
      case CacheStatus.downloading:
        final progress = (cacheModel.downloadProgress ?? 0) * 100;
        icon = Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                value: cacheModel.downloadProgress,
                strokeWidth: 2,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            const Icon(Icons.download, size: 10, color: Colors.blue),
          ],
        );
        color = Colors.blue;
        tooltip = 'ダウンロード中 ${progress.toStringAsFixed(0)}%';
      case CacheStatus.error:
        icon = const Icon(Icons.error_outline, size: 18);
        color = Colors.orange;
        tooltip = 'キャッシュエラー';
      case CacheStatus.notCached:
        icon = const Icon(Icons.cloud_outlined, size: 18);
        color = Colors.grey;
        tooltip = 'ネットワーク再生';
    }

    return Tooltip(
      message: tooltip,
      child: IconTheme(
        data: IconThemeData(color: color),
        child: icon,
      ),
    );
  }

  /// ダウンロードボタンを構築
  Widget _buildDownloadButton(WidgetRef ref, Grape grape) {
    final cacheState = ref.watch(videoCacheServiceProvider);
    final cacheModel = cacheState[grape.grapeId];
    final cacheService = ref.read(videoCacheServiceProvider.notifier);

    switch (cacheModel?.status) {
      case CacheStatus.cached:
        // 既にキャッシュされている場合は削除ボタン
        return IconButton(
          icon: const Icon(Icons.delete_outline, size: 18),
          onPressed: () async {
            await cacheService.deleteCache(grape.grapeId);
          },
          tooltip: 'キャッシュを削除',
          constraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
          iconSize: 18,
        );

      case CacheStatus.downloading:
        // ダウンロード中の場合はキャンセルボタン
        return IconButton(
          icon: const Icon(Icons.close, size: 18),
          onPressed: () async {
            await cacheService.cancelDownload(grape.grapeId);
          },
          tooltip: 'ダウンロードをキャンセル',
          constraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
          iconSize: 18,
        );

      case CacheStatus.error:
      case CacheStatus.notCached:
      case null:
        // キャッシュされていない場合はダウンロードボタン
        return IconButton(
          icon: const Icon(Icons.download, size: 18),
          onPressed: () async {
            if (grape.videoUrl != null) {
              await cacheService.downloadVideoManually(
                grape.grapeId,
                grape.videoUrl!,
              );
            }
          },
          tooltip: 'ダウンロード',
          constraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
          iconSize: 18,
        );
    }
  }
}
