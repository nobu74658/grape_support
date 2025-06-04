// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_cache_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoCacheModelImpl _$$VideoCacheModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VideoCacheModelImpl(
      grapeId: json['grapeId'] as String,
      remoteUrl: json['remoteUrl'] as String,
      localPath: json['localPath'] as String?,
      status: $enumDecode(_$CacheStatusEnumMap, json['status']),
      downloadProgress: (json['downloadProgress'] as num?)?.toDouble(),
      lastAccessed: json['lastAccessed'] == null
          ? null
          : DateTime.parse(json['lastAccessed'] as String),
      fileSizeBytes: json['fileSizeBytes'] as int?,
      fileHash: json['fileHash'] as String?,
    );

Map<String, dynamic> _$$VideoCacheModelImplToJson(
        _$VideoCacheModelImpl instance) =>
    <String, dynamic>{
      'grapeId': instance.grapeId,
      'remoteUrl': instance.remoteUrl,
      'localPath': instance.localPath,
      'status': _$CacheStatusEnumMap[instance.status]!,
      'downloadProgress': instance.downloadProgress,
      'lastAccessed': instance.lastAccessed?.toIso8601String(),
      'fileSizeBytes': instance.fileSizeBytes,
      'fileHash': instance.fileHash,
    };

const _$CacheStatusEnumMap = {
  CacheStatus.notCached: 'notCached',
  CacheStatus.downloading: 'downloading',
  CacheStatus.cached: 'cached',
  CacheStatus.error: 'error',
};
