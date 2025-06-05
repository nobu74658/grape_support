import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/models/video_cache_model.dart';
import 'package:grape_support/services/video_cache_service.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// キャッシュ機能をテストするためのデバッグ関数
class CacheDebugTest {
  static Future<void> runCacheTest(Ref ref) async {
    debugPrint('🧪 === CACHE DEBUG TEST STARTING ===');
    
    try {
      // 1. キャッシュディレクトリの確認
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(path.join(appDir.path, 'video_cache'));
      
      debugPrint('📁 App directory: ${appDir.path}');
      debugPrint('📁 Cache directory: ${cacheDir.path}');
      debugPrint('📁 Cache directory exists: ${cacheDir.existsSync()}');
      
      // 2. キャッシュディレクトリの内容を確認
      if (cacheDir.existsSync()) {
        final files = await cacheDir.list().toList();
        debugPrint('📁 Files in cache directory: ${files.length}');
        
        for (final file in files) {
          if (file is File) {
            final stat = file.statSync();
            final sizeInMB = (stat.size / (1024 * 1024)).toStringAsFixed(2);
            debugPrint('  📄 ${path.basename(file.path)} - ${sizeInMB}MB');
          }
        }
      }
      
      // 3. Riverpod状態の確認
      final cacheState = ref.read(videoCacheServiceProvider);
      debugPrint('🎬 Cache entries in Riverpod state: ${cacheState.length}');
      
      for (final entry in cacheState.entries) {
        final model = entry.value;
        debugPrint('  🎯 ${entry.key}: ${model.status}');
        if (model.localPath != null) {
          final file = File(model.localPath!);
          final exists = file.existsSync();
          debugPrint('    📍 Path: ${model.localPath}');
          debugPrint('    ✅ File exists: $exists');
          if (exists && model.fileSizeBytes != null) {
            final sizeInMB = (model.fileSizeBytes! / (1024 * 1024)).toStringAsFixed(2);
            debugPrint('    📏 Size: ${sizeInMB}MB');
          }
        }
      }
      
      // 4. メタデータファイルの確認
      final metadataFile = File(path.join(cacheDir.path, 'cache_metadata.json'));
      debugPrint('📋 Metadata file exists: ${metadataFile.existsSync()}');
      
      if (metadataFile.existsSync()) {
        final content = await metadataFile.readAsString();
        debugPrint('📋 Metadata content: $content');
      }
      
      // 5. 簡易レポート生成
      debugPrint('📊 === CACHE SUMMARY ===');
      debugPrint('Total cached videos: ${cacheState.length}');
      int cachedCount = 0;
      int downloadingCount = 0;
      int errorCount = 0;
      
      for (final model in cacheState.values) {
        switch (model.status) {
          case CacheStatus.cached:
            cachedCount++;
          case CacheStatus.downloading:
            downloadingCount++;
          case CacheStatus.error:
            errorCount++;
          case CacheStatus.notCached:
            break;
        }
      }
      
      debugPrint('✅ Cached: $cachedCount');
      debugPrint('⬇️ Downloading: $downloadingCount');
      debugPrint('❌ Errors: $errorCount');
      
    } on Exception catch (e, stackTrace) {
      debugPrint('❌ Error in cache debug test: $e');
      debugPrint('📍 Stack trace: $stackTrace');
    }
    
    debugPrint('🧪 === CACHE DEBUG TEST COMPLETED ===');
  }
  
  /// オフライン再生をテストする関数
  static Future<void> testOfflinePlayback(Ref ref, String grapeId) async {
    debugPrint('🔌 === TESTING OFFLINE PLAYBACK ===');
    
    try {
      final cacheState = ref.read(videoCacheServiceProvider);
      final model = cacheState[grapeId];
      
      if (model == null) {
        debugPrint('❌ No cache model found for grapeId: $grapeId');
        return;
      }
      
      debugPrint('🎬 Cache status: ${model.status}');
      
      if (model.status == CacheStatus.cached && model.localPath != null) {
        final file = File(model.localPath!);
        final exists = file.existsSync();
        
        debugPrint('📁 Local path: ${model.localPath}');
        debugPrint('✅ File exists: $exists');
        
        if (exists) {
          final stat = file.statSync();
          final sizeInMB = (stat.size / (1024 * 1024)).toStringAsFixed(2);
          debugPrint('📏 File size: ${sizeInMB}MB');
          debugPrint('🎯 File is ready for offline playback!');
        } else {
          debugPrint('❌ Local file missing despite cached status');
        }
      } else {
        debugPrint('⚠️ Video is not cached or not available offline');
      }
      
    } on Exception catch (e) {
      debugPrint('❌ Error testing offline playback: $e');
    }
    
    debugPrint('🔌 === OFFLINE PLAYBACK TEST COMPLETED ===');
  }
}
