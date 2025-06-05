import 'package:grape_support/models/video_cache_model.dart';
import 'package:grape_support/services/video_cache_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_status_provider.g.dart';

@riverpod
bool isVideoCached(IsVideoCachedRef ref, String grapeId) {
  final cacheState = ref.watch(videoCacheServiceProvider);
  final cacheModel = cacheState[grapeId];
  return cacheModel?.status == CacheStatus.cached;
}

@riverpod
CacheStatus? videoCacheStatus(VideoCacheStatusRef ref, String grapeId) {
  final cacheState = ref.watch(videoCacheServiceProvider);
  return cacheState[grapeId]?.status;
}

@riverpod
double? videoDownloadProgress(VideoDownloadProgressRef ref, String grapeId) {
  final cacheState = ref.watch(videoCacheServiceProvider);
  return cacheState[grapeId]?.downloadProgress;
}

@riverpod
String videoCacheInfo(VideoCacheInfoRef ref, String grapeId) {
  final cacheState = ref.watch(videoCacheServiceProvider);
  final cacheModel = cacheState[grapeId];
  
  if (cacheModel == null) {
    return 'キャッシュなし';
  }
  
  switch (cacheModel.status) {
    case CacheStatus.cached:
      final sizeInfo = cacheModel.fileSizeBytes != null 
        ? ' (${(cacheModel.fileSizeBytes! / (1024 * 1024)).toStringAsFixed(1)}MB)'
        : '';
      return 'ローカル保存済み$sizeInfo';
    case CacheStatus.downloading:
      final progress = (cacheModel.downloadProgress ?? 0) * 100;
      return 'ダウンロード中 ${progress.toStringAsFixed(0)}%';
    case CacheStatus.error:
      return 'キャッシュエラー';
    case CacheStatus.notCached:
      return 'ネットワーク再生';
  }
}
