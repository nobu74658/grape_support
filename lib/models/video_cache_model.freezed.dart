// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_cache_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoCacheModel _$VideoCacheModelFromJson(Map<String, dynamic> json) {
  return _VideoCacheModel.fromJson(json);
}

/// @nodoc
mixin _$VideoCacheModel {
  String get grapeId => throw _privateConstructorUsedError;
  String get remoteUrl => throw _privateConstructorUsedError;
  String? get localPath => throw _privateConstructorUsedError;
  CacheStatus get status => throw _privateConstructorUsedError;
  double? get downloadProgress => throw _privateConstructorUsedError;
  DateTime? get lastAccessed => throw _privateConstructorUsedError;
  int? get fileSizeBytes => throw _privateConstructorUsedError;
  String? get fileHash => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoCacheModelCopyWith<VideoCacheModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCacheModelCopyWith<$Res> {
  factory $VideoCacheModelCopyWith(
          VideoCacheModel value, $Res Function(VideoCacheModel) then) =
      _$VideoCacheModelCopyWithImpl<$Res, VideoCacheModel>;
  @useResult
  $Res call(
      {String grapeId,
      String remoteUrl,
      String? localPath,
      CacheStatus status,
      double? downloadProgress,
      DateTime? lastAccessed,
      int? fileSizeBytes,
      String? fileHash});
}

/// @nodoc
class _$VideoCacheModelCopyWithImpl<$Res, $Val extends VideoCacheModel>
    implements $VideoCacheModelCopyWith<$Res> {
  _$VideoCacheModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grapeId = null,
    Object? remoteUrl = null,
    Object? localPath = freezed,
    Object? status = null,
    Object? downloadProgress = freezed,
    Object? lastAccessed = freezed,
    Object? fileSizeBytes = freezed,
    Object? fileHash = freezed,
  }) {
    return _then(_value.copyWith(
      grapeId: null == grapeId
          ? _value.grapeId
          : grapeId // ignore: cast_nullable_to_non_nullable
              as String,
      remoteUrl: null == remoteUrl
          ? _value.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CacheStatus,
      downloadProgress: freezed == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double?,
      lastAccessed: freezed == lastAccessed
          ? _value.lastAccessed
          : lastAccessed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fileSizeBytes: freezed == fileSizeBytes
          ? _value.fileSizeBytes
          : fileSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      fileHash: freezed == fileHash
          ? _value.fileHash
          : fileHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoCacheModelImplCopyWith<$Res>
    implements $VideoCacheModelCopyWith<$Res> {
  factory _$$VideoCacheModelImplCopyWith(_$VideoCacheModelImpl value,
          $Res Function(_$VideoCacheModelImpl) then) =
      __$$VideoCacheModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String grapeId,
      String remoteUrl,
      String? localPath,
      CacheStatus status,
      double? downloadProgress,
      DateTime? lastAccessed,
      int? fileSizeBytes,
      String? fileHash});
}

/// @nodoc
class __$$VideoCacheModelImplCopyWithImpl<$Res>
    extends _$VideoCacheModelCopyWithImpl<$Res, _$VideoCacheModelImpl>
    implements _$$VideoCacheModelImplCopyWith<$Res> {
  __$$VideoCacheModelImplCopyWithImpl(
      _$VideoCacheModelImpl _value, $Res Function(_$VideoCacheModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grapeId = null,
    Object? remoteUrl = null,
    Object? localPath = freezed,
    Object? status = null,
    Object? downloadProgress = freezed,
    Object? lastAccessed = freezed,
    Object? fileSizeBytes = freezed,
    Object? fileHash = freezed,
  }) {
    return _then(_$VideoCacheModelImpl(
      grapeId: null == grapeId
          ? _value.grapeId
          : grapeId // ignore: cast_nullable_to_non_nullable
              as String,
      remoteUrl: null == remoteUrl
          ? _value.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CacheStatus,
      downloadProgress: freezed == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double?,
      lastAccessed: freezed == lastAccessed
          ? _value.lastAccessed
          : lastAccessed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fileSizeBytes: freezed == fileSizeBytes
          ? _value.fileSizeBytes
          : fileSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      fileHash: freezed == fileHash
          ? _value.fileHash
          : fileHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoCacheModelImpl implements _VideoCacheModel {
  const _$VideoCacheModelImpl(
      {required this.grapeId,
      required this.remoteUrl,
      this.localPath,
      required this.status,
      this.downloadProgress,
      this.lastAccessed,
      this.fileSizeBytes,
      this.fileHash});

  factory _$VideoCacheModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoCacheModelImplFromJson(json);

  @override
  final String grapeId;
  @override
  final String remoteUrl;
  @override
  final String? localPath;
  @override
  final CacheStatus status;
  @override
  final double? downloadProgress;
  @override
  final DateTime? lastAccessed;
  @override
  final int? fileSizeBytes;
  @override
  final String? fileHash;

  @override
  String toString() {
    return 'VideoCacheModel(grapeId: $grapeId, remoteUrl: $remoteUrl, localPath: $localPath, status: $status, downloadProgress: $downloadProgress, lastAccessed: $lastAccessed, fileSizeBytes: $fileSizeBytes, fileHash: $fileHash)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoCacheModelImpl &&
            (identical(other.grapeId, grapeId) || other.grapeId == grapeId) &&
            (identical(other.remoteUrl, remoteUrl) ||
                other.remoteUrl == remoteUrl) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.downloadProgress, downloadProgress) ||
                other.downloadProgress == downloadProgress) &&
            (identical(other.lastAccessed, lastAccessed) ||
                other.lastAccessed == lastAccessed) &&
            (identical(other.fileSizeBytes, fileSizeBytes) ||
                other.fileSizeBytes == fileSizeBytes) &&
            (identical(other.fileHash, fileHash) ||
                other.fileHash == fileHash));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, grapeId, remoteUrl, localPath,
      status, downloadProgress, lastAccessed, fileSizeBytes, fileHash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoCacheModelImplCopyWith<_$VideoCacheModelImpl> get copyWith =>
      __$$VideoCacheModelImplCopyWithImpl<_$VideoCacheModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoCacheModelImplToJson(
      this,
    );
  }
}

abstract class _VideoCacheModel implements VideoCacheModel {
  const factory _VideoCacheModel(
      {required final String grapeId,
      required final String remoteUrl,
      final String? localPath,
      required final CacheStatus status,
      final double? downloadProgress,
      final DateTime? lastAccessed,
      final int? fileSizeBytes,
      final String? fileHash}) = _$VideoCacheModelImpl;

  factory _VideoCacheModel.fromJson(Map<String, dynamic> json) =
      _$VideoCacheModelImpl.fromJson;

  @override
  String get grapeId;
  @override
  String get remoteUrl;
  @override
  String? get localPath;
  @override
  CacheStatus get status;
  @override
  double? get downloadProgress;
  @override
  DateTime? get lastAccessed;
  @override
  int? get fileSizeBytes;
  @override
  String? get fileHash;
  @override
  @JsonKey(ignore: true)
  _$$VideoCacheModelImplCopyWith<_$VideoCacheModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
