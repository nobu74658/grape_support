import 'package:flutter/foundation.dart';
import 'package:grape_support/services/video_cache_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_manager.g.dart';

@riverpod
class CacheManager extends _$CacheManager {
  @override
  void build() {}

  /// アプリ起動時にキャッシュクリーンアップを実行
  Future<void> initializeCache() async {
    try {
      final cacheService = ref.read(videoCacheServiceProvider.notifier);
      
      // メタデータの読み込みを確実に実行
      debugPrint('🔄 Loading cache metadata on app startup...');
      await cacheService.loadCacheMetadata();
      
      // 読み込み後の状態をログ出力
      final cacheState = ref.read(videoCacheServiceProvider);
      debugPrint('📊 Loaded ${cacheState.length} cache entries');
      
      // キャッシュクリーンアップ
      await cacheService.cleanupCache();
      
      debugPrint('✅ Cache initialization completed');
    } on Exception catch (e) {
      debugPrint('❌ Cache initialization failed: $e');
    }
  }

  /// 定期的なキャッシュクリーンアップ
  Future<void> periodicCleanup() async {
    final cacheService = ref.read(videoCacheServiceProvider.notifier);
    await cacheService.cleanupCache();
  }

  /// キャッシュ使用量を取得
  Future<double> getCacheSize() async {
    final cacheService = ref.read(videoCacheServiceProvider);
    int totalSize = 0;
    
    for (final model in cacheService.values) {
      if (model.fileSizeBytes != null) {
        totalSize += model.fileSizeBytes!;
      }
    }
    
    return totalSize / (1024 * 1024); // MB単位で返す
  }

  /// 全キャッシュクリア
  Future<void> clearAllCache() async {
    final cacheService = ref.read(videoCacheServiceProvider.notifier);
    await cacheService.clearAllCache();
  }
}
