import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/services/video_cache_service.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_cache_helper.g.dart';

@riverpod
class DebugCacheHelper extends _$DebugCacheHelper {
  @override
  void build() {}

  /// キャッシュディレクトリの詳細情報を取得
  Future<Map<String, dynamic>> getCacheDirectoryInfo() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(path.join(appDir.path, 'video_cache'));
      
      final info = <String, dynamic>{
        'cacheDirectory': cacheDir.path,
        'exists': cacheDir.existsSync(),
        'files': <Map<String, dynamic>>[],
      };

      if (cacheDir.existsSync()) {
        final files = await cacheDir.list().toList();
        for (final file in files) {
          if (file is File) {
            final stat = file.statSync();
            info['files'].add({
              'name': path.basename(file.path),
              'path': file.path,
              'size': stat.size,
              'sizeInMB': (stat.size / (1024 * 1024)).toStringAsFixed(2),
              'created': stat.changed.toString(),
              'modified': stat.modified.toString(),
            });
          }
        }
      }

      return info;
    } on Exception catch (e) {
      return {'error': e.toString()};
    }
  }

  /// キャッシュ状態とファイル存在の整合性をチェック
  Future<Map<String, dynamic>> validateCacheConsistency(WidgetRef ref) async {
    final cacheService = ref.read(videoCacheServiceProvider);
    final results = <String, dynamic>{};
    
    for (final entry in cacheService.entries) {
      final grapeId = entry.key;
      final model = entry.value;
      
      final validation = <String, dynamic>{
        'grapeId': grapeId,
        'status': model.status.toString(),
        'localPath': model.localPath,
        'remoteUrl': model.remoteUrl,
        'fileSizeBytes': model.fileSizeBytes,
      };

      if (model.localPath != null) {
        final file = File(model.localPath!);
        validation['fileExists'] = file.existsSync();
        
        if (file.existsSync()) {
          final stat = file.statSync();
          validation['actualFileSize'] = stat.size;
          validation['sizeMismatch'] = model.fileSizeBytes != null 
            && (stat.size != model.fileSizeBytes!);
        }
      }

      results[grapeId] = validation;
    }

    return results;
  }

  /// キャッシュメタデータファイルの内容を取得
  Future<Map<String, dynamic>> getCacheMetadataContent() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final metadataFile = File(path.join(appDir.path, 'video_cache', 'cache_metadata.json'));
      
      if (!metadataFile.existsSync()) {
        return {'exists': false, 'path': metadataFile.path};
      }

      final content = await metadataFile.readAsString();
      return {
        'exists': true,
        'path': metadataFile.path,
        'content': content,
        'size': metadataFile.statSync().size,
      };
    } on Exception catch (e) {
      return {'error': e.toString()};
    }
  }

  /// 詳細デバッグレポートを生成
  Future<String> generateDebugReport(WidgetRef ref) async {
    final directoryInfo = await getCacheDirectoryInfo();
    final consistencyCheck = await validateCacheConsistency(ref);
    final metadataInfo = await getCacheMetadataContent();
    final cacheState = ref.read(videoCacheServiceProvider);

    final report = StringBuffer()
      ..writeln('=== VIDEO CACHE DEBUG REPORT ===')
      ..writeln('Generated: ${DateTime.now()}')
      ..writeln()
      ..writeln('=== CACHE DIRECTORY ===')
      ..writeln('Path: ${directoryInfo['cacheDirectory']}')
      ..writeln('Exists: ${directoryInfo['exists']}');
      
    if (directoryInfo['files'] != null) {
      report.writeln('Files count: ${(directoryInfo['files'] as List).length}');
      for (final file in directoryInfo['files'] as List) {
        report.writeln('  - ${file['name']} (${file['sizeInMB']}MB)');
      }
    }
    
    report
      ..writeln()
      ..writeln('=== METADATA FILE ===')
      ..writeln('Exists: ${metadataInfo['exists']}');
      
    if (metadataInfo['exists'] == true) {
      report
        ..writeln('Size: ${metadataInfo['size']} bytes')
        ..writeln('Content: ${metadataInfo['content']}');
    }
    
    report
      ..writeln()
      ..writeln('=== RIVERPOD STATE ===')
      ..writeln('Cache entries: ${cacheState.length}');
      
    for (final entry in cacheState.entries) {
      report.writeln('  ${entry.key}: ${entry.value.status}');
    }
    
    report
      ..writeln()
      ..writeln('=== CONSISTENCY CHECK ===');
      
    for (final entry in consistencyCheck.entries) {
      final grapeId = entry.key;
      final validation = entry.value;
      report
        ..writeln('$grapeId:')
        ..writeln('  Status: ${validation['status']}')
        ..writeln('  Local path: ${validation['localPath']}')
        ..writeln('  File exists: ${validation['fileExists']}');
      if (validation['sizeMismatch'] == true) {
        report.writeln('  ⚠️  SIZE MISMATCH: Expected ${validation['fileSizeBytes']}, Actual ${validation['actualFileSize']}');
      }
    }

    return report.toString();
  }

  /// 強制的にキャッシュメタデータを再読み込み
  Future<void> forceReloadCache(WidgetRef ref) async {
    final cacheService = ref.read(videoCacheServiceProvider.notifier);
    await cacheService.loadCacheMetadata();
    debugPrint('Cache metadata forcefully reloaded');
  }
}
