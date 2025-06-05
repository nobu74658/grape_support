import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_cache_model.freezed.dart';
part 'video_cache_model.g.dart';

@freezed
class VideoCacheModel with _$VideoCacheModel {
  const factory VideoCacheModel({
    required String grapeId,
    required String remoteUrl,
    required CacheStatus status, String? localPath,
    double? downloadProgress,
    DateTime? lastAccessed,
    int? fileSizeBytes,
    String? fileHash,
  }) = _VideoCacheModel;

  factory VideoCacheModel.fromJson(Map<String, dynamic> json) =>
      _$VideoCacheModelFromJson(json);
}

enum CacheStatus {
  @JsonValue('notCached')
  notCached,
  @JsonValue('downloading')
  downloading,
  @JsonValue('cached')
  cached,
  @JsonValue('error')
  error,
}
