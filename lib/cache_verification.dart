import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// 簡単なキャッシュ検証ユーティリティ
class CacheVerification {
  /// キャッシュディレクトリの状態を確認
  static Future<void> checkCacheDirectory() async {
    try {
      debugPrint('🔍 === CHECKING CACHE DIRECTORY ===');
      
      // アプリのドキュメントディレクトリを取得
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(path.join(appDir.path, 'video_cache'));
      
      debugPrint('📁 App documents directory: ${appDir.path}');
      debugPrint('📁 Video cache directory: ${cacheDir.path}');
      debugPrint('📁 Cache directory exists: ${cacheDir.existsSync()}');
      
      if (!cacheDir.existsSync()) {
        debugPrint('⚠️ Cache directory does not exist yet');
        return;
      }
      
      // キャッシュディレクトリ内のファイルを一覧表示
      final files = await cacheDir.list().toList();
      debugPrint('📄 Files in cache directory: ${files.length}');
      
      if (files.isEmpty) {
        debugPrint('📂 Cache directory is empty');
        return;
      }
      
      double totalSizeMB = 0;
      int videoFileCount = 0;
      
      for (final file in files) {
        if (file is File) {
          final stat = file.statSync();
          final sizeInMB = stat.size / (1024 * 1024);
          totalSizeMB += sizeInMB;
          
          final fileName = path.basename(file.path);
          debugPrint('  📹 $fileName - ${sizeInMB.toStringAsFixed(2)}MB');
          
          if (fileName.endsWith('.mp4') || fileName.endsWith('.mov')) {
            videoFileCount++;
          }
        }
      }
      
      debugPrint('📊 Total cached files: ${files.length}');
      debugPrint('🎬 Video files: $videoFileCount');
      debugPrint('💾 Total cache size: ${totalSizeMB.toStringAsFixed(2)}MB');
      
      // メタデータファイルの確認
      final metadataFile = File(path.join(cacheDir.path, 'cache_metadata.json'));
      if (metadataFile.existsSync()) {
        final content = await metadataFile.readAsString();
        debugPrint('📋 Metadata file exists (${metadataFile.statSync().size} bytes)');
        debugPrint('📋 Metadata content preview: ${content.substring(0, content.length > 200 ? 200 : content.length)}...');
      } else {
        debugPrint('❌ Metadata file does not exist');
      }
      
    } on Exception catch (e) {
      debugPrint('❌ Error checking cache directory: $e');
    }
    
    debugPrint('🔍 === CACHE CHECK COMPLETED ===');
  }
  
  /// 特定のキャッシュファイルが存在するかチェック
  static Future<bool> isFileCached(String grapeId) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(path.join(appDir.path, 'video_cache'));
      
      if (!cacheDir.existsSync()) {
        return false;
      }
      
      final files = await cacheDir.list().toList();
      
      for (final file in files) {
        if (file is File) {
          final fileName = path.basename(file.path);
          if (fileName.startsWith(grapeId)) {
            debugPrint('✅ Found cached file for $grapeId: $fileName');
            return true;
          }
        }
      }
      
      debugPrint('❌ No cached file found for $grapeId');
      return false;
      
    } on Exception catch (e) {
      debugPrint('❌ Error checking file cache for $grapeId: $e');
      return false;
    }
  }
  
  /// キャッシュファイルサイズの合計を取得
  static Future<double> getTotalCacheSizeMB() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(path.join(appDir.path, 'video_cache'));
      
      if (!cacheDir.existsSync()) {
        return 0.0;
      }
      
      final files = await cacheDir.list().toList();
      double totalSize = 0;
      
      for (final file in files) {
        if (file is File) {
          final stat = file.statSync();
          totalSize += stat.size;
        }
      }
      
      return totalSize / (1024 * 1024);
      
    } on Exception catch (e) {
      debugPrint('❌ Error calculating cache size: $e');
      return 0.0;
    }
  }
}
