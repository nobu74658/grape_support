import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:grape_support/models/video_cache_model.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_cache_service.g.dart';

@riverpod
class VideoCacheService extends _$VideoCacheService {
  static const String _cacheDir = 'video_cache';
  static const String _metadataFile = 'cache_metadata.json';
  static const int _maxCacheSizeBytes = 500 * 1024 * 1024; // 500MB

  @override
  Map<String, VideoCacheModel> build() => {};

  /// 動画をローカルキャッシュから取得、なければダウンロード
  Future<String?> getVideo(String grapeId, String remoteUrl) async {
    final cacheModel = state[grapeId];

    // 既にキャッシュされている場合
    if (cacheModel?.status == CacheStatus.cached && 
        cacheModel?.localPath != null) {
      final file = File(cacheModel!.localPath!);
      if (await file.exists()) {
        // アクセス時間を更新
        await _updateLastAccessed(grapeId);
        return cacheModel.localPath;
      }
    }

    // ダウンロード中の場合は待機
    if (cacheModel?.status == CacheStatus.downloading) {
      return null; // UI側でローディング表示
    }

    // 新規ダウンロード
    return _downloadVideo(grapeId, remoteUrl);
  }

  /// 動画をローカルに保存
  Future<String?> saveVideoLocally(String grapeId, String filePath) async {
    try {
      final cacheDir = await _getCacheDirectory();
      final file = File(filePath);
      
      if (!await file.exists()) {
        debugPrint('Source file does not exist: $filePath');
        return null;
      }

      final fileBytes = await file.readAsBytes();
      final hash = _generateFileHash(fileBytes);
      final extension = path.extension(filePath);
      final cachedFileName = '${grapeId}_$hash$extension';
      final cachedFile = File(path.join(cacheDir.path, cachedFileName));

      // ファイルをコピー
      await cachedFile.writeAsBytes(fileBytes);

      // メタデータを更新
      final cacheModel = VideoCacheModel(
        grapeId: grapeId,
        remoteUrl: '', // ローカル保存時は空
        localPath: cachedFile.path,
        status: CacheStatus.cached,
        lastAccessed: DateTime.now(),
        fileSizeBytes: fileBytes.length,
        fileHash: hash,
      );

      state = {...state, grapeId: cacheModel};
      await _saveCacheMetadata();

      debugPrint('Video saved locally: ${cachedFile.path}');
      return cachedFile.path;
    } catch (e) {
      debugPrint('Error saving video locally: $e');
      return null;
    }
  }

  /// 動画をダウンロード
  Future<String?> _downloadVideo(String grapeId, String remoteUrl) async {
    try {
      // ダウンロード開始状態に更新
      final downloadingModel = VideoCacheModel(
        grapeId: grapeId,
        remoteUrl: remoteUrl,
        status: CacheStatus.downloading,
        downloadProgress: 0,
      );
      state = {...state, grapeId: downloadingModel};

      final cacheDir = await _getCacheDirectory();
      final extension = path.extension(Uri.parse(remoteUrl).path);
      final tempFileName = '${grapeId}_temp$extension';
      final tempFile = File(path.join(cacheDir.path, tempFileName));

      final dio = Dio();
      await dio.download(
        remoteUrl,
        tempFile.path,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            final progress = received / total;
            final updatedModel = state[grapeId]?.copyWith(
              downloadProgress: progress,
            );
            if (updatedModel != null) {
              state = {...state, grapeId: updatedModel};
            }
          }
        },
      );

      // ダウンロード完了後、ハッシュ生成とファイル名変更
      final fileBytes = await tempFile.readAsBytes();
      final hash = _generateFileHash(fileBytes);
      final finalFileName = '${grapeId}_$hash$extension';
      final finalFile = File(path.join(cacheDir.path, finalFileName));
      
      await tempFile.rename(finalFile.path);

      // キャッシュ完了状態に更新
      final cachedModel = VideoCacheModel(
        grapeId: grapeId,
        remoteUrl: remoteUrl,
        localPath: finalFile.path,
        status: CacheStatus.cached,
        downloadProgress: 1,
        lastAccessed: DateTime.now(),
        fileSizeBytes: fileBytes.length,
        fileHash: hash,
      );

      state = {...state, grapeId: cachedModel};
      await _saveCacheMetadata();

      debugPrint('Video downloaded successfully: ${finalFile.path}');
      return finalFile.path;
    } catch (e) {
      debugPrint('Error downloading video: $e');
      
      // エラー状態に更新
      final errorModel = state[grapeId]?.copyWith(
        status: CacheStatus.error,
      );
      if (errorModel != null) {
        state = {...state, grapeId: errorModel};
      }
      
      return null;
    }
  }

  /// キャッシュディレクトリを取得
  Future<Directory> _getCacheDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory(path.join(appDir.path, _cacheDir));
    
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    
    return cacheDir;
  }

  /// ファイルハッシュを生成
  String _generateFileHash(List<int> bytes) {
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// 最終アクセス時間を更新
  Future<void> _updateLastAccessed(String grapeId) async {
    final model = state[grapeId];
    if (model != null) {
      final updatedModel = model.copyWith(lastAccessed: DateTime.now());
      state = {...state, grapeId: updatedModel};
      await _saveCacheMetadata();
    }
  }

  /// キャッシュメタデータを読み込み
  Future<void> loadCacheMetadata() async {
    try {
      final cacheDir = await _getCacheDirectory();
      final metadataFile = File(path.join(cacheDir.path, _metadataFile));
      
      if (await metadataFile.exists()) {
        final jsonString = await metadataFile.readAsString();
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        
        final Map<String, VideoCacheModel> loadedCache = {};
        for (final entry in jsonData.entries) {
          loadedCache[entry.key] = VideoCacheModel.fromJson(entry.value);
        }
        
        state = loadedCache;
      }
    } catch (e) {
      debugPrint('Error loading cache metadata: $e');
    }
  }

  /// キャッシュメタデータを保存
  Future<void> _saveCacheMetadata() async {
    try {
      final cacheDir = await _getCacheDirectory();
      final metadataFile = File(path.join(cacheDir.path, _metadataFile));
      
      final Map<String, dynamic> jsonData = {};
      for (final entry in state.entries) {
        jsonData[entry.key] = entry.value.toJson();
      }
      
      await metadataFile.writeAsString(json.encode(jsonData));
    } catch (e) {
      debugPrint('Error saving cache metadata: $e');
    }
  }

  /// キャッシュクリーンアップ（容量制限・古いファイル削除）
  Future<void> cleanupCache() async {
    try {
      int totalSize = 0;
      
      // 現在のキャッシュサイズを計算
      for (final model in state.values) {
        if (model.fileSizeBytes != null) {
          totalSize += model.fileSizeBytes!;
        }
      }

      // 容量制限を超えている場合、古いファイルから削除
      if (totalSize > _maxCacheSizeBytes) {
        final sortedModels = state.values.toList()
          ..sort((a, b) {
            final aTime = a.lastAccessed ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bTime = b.lastAccessed ?? DateTime.fromMillisecondsSinceEpoch(0);
            return aTime.compareTo(bTime);
          });

        final updatedState = Map<String, VideoCacheModel>.from(state);
        
        for (final model in sortedModels) {
          if (totalSize <= (_maxCacheSizeBytes * 0.8).round()) break;
          
          if (model.localPath != null) {
            final file = File(model.localPath!);
            if (await file.exists()) {
              await file.delete();
            }
          }
          
          if (model.fileSizeBytes != null) {
            totalSize -= model.fileSizeBytes!;
          }
          
          updatedState.remove(model.grapeId);
        }
        
        state = updatedState;
        await _saveCacheMetadata();
        
        final sizeInMB = totalSize / (1024 * 1024);
        debugPrint('Cache cleanup completed. New size: ${sizeInMB.toStringAsFixed(2)}MB');
      }
    } catch (e) {
      debugPrint('Error during cache cleanup: $e');
    }
  }

  /// 特定の動画キャッシュを削除
  Future<void> deleteCache(String grapeId) async {
    final model = state[grapeId];
    if (model?.localPath != null) {
      final file = File(model!.localPath!);
      if (await file.exists()) {
        await file.delete();
      }
    }
    
    final updatedState = Map<String, VideoCacheModel>.from(state);
    updatedState.remove(grapeId);
    state = updatedState;
    
    await _saveCacheMetadata();
  }

  /// 全キャッシュを削除
  Future<void> clearAllCache() async {
    try {
      final cacheDir = await _getCacheDirectory();
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
      }
      state = {};
      debugPrint('All cache cleared');
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }
}