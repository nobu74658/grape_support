import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// キャッシュの詳細な場所を表示するデバッグ用クラス
class CacheLocationDebugger {
  
  /// 現在のキャッシュディレクトリのフルパスを表示
  static Future<void> showCacheLocation() async {
    try {
      // アプリのDocumentsディレクトリを取得
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(path.join(appDir.path, 'video_cache'));
      
      debugPrint('=== キャッシュ保存場所 ===');
      debugPrint('📱 プラットフォーム: ${Platform.operatingSystem}');
      debugPrint('📁 アプリDocumentsディレクトリ: ${appDir.path}');
      debugPrint('🎬 ビデオキャッシュディレクトリ: ${cacheDir.path}');
      debugPrint('✅ ディレクトリ存在: ${cacheDir.existsSync()}');
      
      if (cacheDir.existsSync()) {
        final files = await cacheDir.list().toList();
        debugPrint('📄 キャッシュファイル数: ${files.length}');
        
        for (final file in files) {
          if (file is File) {
            final stat = file.statSync();
            final fileName = path.basename(file.path);
            final sizeInMB = (stat.size / (1024 * 1024)).toStringAsFixed(2);
            debugPrint('  🎯 $fileName (${sizeInMB}MB)');
            debugPrint('      フルパス: ${file.path}');
          }
        }
        
        // メタデータファイルの確認
        final metadataFile = File(path.join(cacheDir.path, 'cache_metadata.json'));
        if (metadataFile.existsSync()) {
          debugPrint('📋 メタデータファイル: ${metadataFile.path}');
          final content = await metadataFile.readAsString();
          debugPrint('📋 メタデータ内容: ${content.substring(0, content.length > 200 ? 200 : content.length)}...');
        }
      }
      
      debugPrint('=== キャッシュ場所確認完了 ===');
      
    } on Exception catch (e) {
      debugPrint('❌ キャッシュ場所確認エラー: $e');
    }
  }
  
  /// キャッシュファイルの命名規則を説明
  static void explainCacheNaming() {
    debugPrint('=== キャッシュファイル命名規則 ===');
    debugPrint('📝 形式: {grapeId}_{SHA256ハッシュ}.{拡張子}');
    debugPrint('📝 例: abc123_a1b2c3d4e5f6...xyz.mp4');
    debugPrint('📝 目的: ファイル整合性チェックと重複回避');
    debugPrint('📝 メタデータ: cache_metadata.json');
  }
  
  /// キャッシュ容量制限の説明
  static void explainCacheSettings() {
    debugPrint('=== キャッシュ設定 ===');
    debugPrint('💾 最大容量: 500MB');
    debugPrint('🔄 クリーンアップ: LRU (最古アクセスから削除)');
    debugPrint('📏 クリーンアップ閾値: 400MB (80%)');
    debugPrint('🔐 ファイル整合性: SHA256ハッシュ');
  }
}
