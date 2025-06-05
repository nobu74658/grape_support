import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/models/video_cache_model.dart';
import 'package:grape_support/services/cache_manager.dart';
import 'package:grape_support/services/video_cache_service.dart';

class CacheDebugScreen extends ConsumerStatefulWidget {
  const CacheDebugScreen({super.key});

  @override
  CacheDebugScreenState createState() => CacheDebugScreenState();
}

class CacheDebugScreenState extends ConsumerState<CacheDebugScreen> {
  double _cacheSize = 0;

  @override
  void initState() {
    super.initState();
    unawaited(_loadCacheSize());
  }

  Future<void> _loadCacheSize() async {
    final cacheManager = ref.read(cacheManagerProvider.notifier);
    final size = await cacheManager.getCacheSize();
    setState(() {
      _cacheSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cacheState = ref.watch(videoCacheServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('キャッシュデバッグ情報'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              final cacheService = ref.read(videoCacheServiceProvider.notifier);
              await cacheService.loadCacheMetadata();
              await _loadCacheSize();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _showClearCacheDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // キャッシュ統計
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'キャッシュ統計',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('キャッシュファイル数: ${cacheState.length}'),
                  Text('使用容量: ${_cacheSize.toStringAsFixed(2)} MB'),
                  const Text('制限容量: 500 MB'),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _cacheSize / 500,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _cacheSize > 400 ? Colors.red : Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // キャッシュファイル一覧
          Expanded(
            child: ListView.builder(
              itemCount: cacheState.length,
              itemBuilder: (context, index) {
                final entry = cacheState.entries.elementAt(index);
                final grapeId = entry.key;
                final model = entry.value;
                
                return _buildCacheItem(grapeId, model);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCacheItem(String grapeId, VideoCacheModel model) => Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        leading: _buildStatusIcon(model.status),
        title: Text('Grape ID: $grapeId'),
        subtitle: Text(_getStatusText(model)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('ステータス', _getStatusText(model)),
                if (model.localPath != null) ...[
                  _buildInfoRow('ローカルパス', model.localPath!),
                  _buildInfoRow('ファイル存在', _checkFileExists(model.localPath!)),
                ],
                if (model.fileSizeBytes != null)
                  _buildInfoRow('ファイルサイズ', '${(model.fileSizeBytes! / (1024 * 1024)).toStringAsFixed(2)} MB'),
                if (model.downloadProgress != null)
                  _buildInfoRow('ダウンロード進捗', '${(model.downloadProgress! * 100).toStringAsFixed(1)}%'),
                if (model.lastAccessed != null)
                  _buildInfoRow('最終アクセス', model.lastAccessed!.toString()),
                if (model.fileHash != null)
                  _buildInfoRow('ファイルハッシュ', '${model.fileHash!.substring(0, 16)}...'),
                if (model.remoteUrl.isNotEmpty)
                  _buildInfoRow('リモートURL', model.remoteUrl),
                
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async => _deleteCache(grapeId),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('削除'),
                    ),
                    const SizedBox(width: 8),
                    if (model.localPath != null)
                      ElevatedButton(
                        onPressed: () async => _showFileInfo(model.localPath!),
                        child: const Text('ファイル詳細'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

  Widget _buildInfoRow(String label, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );

  Widget _buildStatusIcon(CacheStatus status) {
    switch (status) {
      case CacheStatus.cached:
        return const Icon(Icons.check_circle, color: Colors.green);
      case CacheStatus.downloading:
        return const Icon(Icons.download, color: Colors.blue);
      case CacheStatus.error:
        return const Icon(Icons.error, color: Colors.red);
      case CacheStatus.notCached:
        return const Icon(Icons.cloud_outlined, color: Colors.grey);
    }
  }

  String _getStatusText(VideoCacheModel model) {
    switch (model.status) {
      case CacheStatus.cached:
        return 'キャッシュ済み';
      case CacheStatus.downloading:
        return 'ダウンロード中 (${(model.downloadProgress ?? 0 * 100).toStringAsFixed(1)}%)';
      case CacheStatus.error:
        return 'エラー';
      case CacheStatus.notCached:
        return 'キャッシュなし';
    }
  }

  String _checkFileExists(String path) {
    try {
      final file = File(path);
      return file.existsSync() ? '存在する' : '存在しない';
    } on Exception catch (e) {
      return 'エラー: $e';
    }
  }

  Future<void> _showFileInfo(String path) async {
    try {
      final file = File(path);
      final stat = file.statSync();
      
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('ファイル詳細'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('パス: $path'),
                Text('サイズ: ${(stat.size / (1024 * 1024)).toStringAsFixed(2)} MB'),
                Text('作成日時: ${stat.changed}'),
                Text('変更日時: ${stat.modified}'),
                Text('アクセス日時: ${stat.accessed}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('閉じる'),
              ),
            ],
          ),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ファイル情報の取得に失敗: $e')),
        );
      }
    }
  }

  Future<void> _deleteCache(String grapeId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('キャッシュ削除'),
        content: Text('Grape ID: $grapeId のキャッシュを削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      final cacheService = ref.read(videoCacheServiceProvider.notifier);
      await cacheService.deleteCache(grapeId);
      await _loadCacheSize();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('キャッシュを削除しました')),
        );
      }
    }
  }

  Future<void> _showClearCacheDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('全キャッシュクリア'),
        content: const Text('すべてのキャッシュを削除しますか？\nこの操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('全削除'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      final cacheManager = ref.read(cacheManagerProvider.notifier);
      await cacheManager.clearAllCache();
      await _loadCacheSize();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('すべてのキャッシュを削除しました')),
        );
      }
    }
  }
}
