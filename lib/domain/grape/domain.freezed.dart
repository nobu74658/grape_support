// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'domain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Grape _$GrapeFromJson(Map<String, dynamic> json) {
  return _Grape.fromJson(json);
}

/// @nodoc
mixin _$Grape {
  String get grapeId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GrapeCopyWith<Grape> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GrapeCopyWith<$Res> {
  factory $GrapeCopyWith(Grape value, $Res Function(Grape) then) =
      _$GrapeCopyWithImpl<$Res, Grape>;
  @useResult
  $Res call({String grapeId, DateTime createdAt, String? videoUrl});
}

/// @nodoc
class _$GrapeCopyWithImpl<$Res, $Val extends Grape>
    implements $GrapeCopyWith<$Res> {
  _$GrapeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grapeId = null,
    Object? createdAt = null,
    Object? videoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      grapeId: null == grapeId
          ? _value.grapeId
          : grapeId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GrapeImplCopyWith<$Res> implements $GrapeCopyWith<$Res> {
  factory _$$GrapeImplCopyWith(
          _$GrapeImpl value, $Res Function(_$GrapeImpl) then) =
      __$$GrapeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String grapeId, DateTime createdAt, String? videoUrl});
}

/// @nodoc
class __$$GrapeImplCopyWithImpl<$Res>
    extends _$GrapeCopyWithImpl<$Res, _$GrapeImpl>
    implements _$$GrapeImplCopyWith<$Res> {
  __$$GrapeImplCopyWithImpl(
      _$GrapeImpl _value, $Res Function(_$GrapeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grapeId = null,
    Object? createdAt = null,
    Object? videoUrl = freezed,
  }) {
    return _then(_$GrapeImpl(
      grapeId: null == grapeId
          ? _value.grapeId
          : grapeId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GrapeImpl implements _Grape {
  const _$GrapeImpl(
      {required this.grapeId, required this.createdAt, this.videoUrl});

  factory _$GrapeImpl.fromJson(Map<String, dynamic> json) =>
      _$$GrapeImplFromJson(json);

  @override
  final String grapeId;
  @override
  final DateTime createdAt;
  @override
  final String? videoUrl;

  @override
  String toString() {
    return 'Grape(grapeId: $grapeId, createdAt: $createdAt, videoUrl: $videoUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GrapeImpl &&
            (identical(other.grapeId, grapeId) || other.grapeId == grapeId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, grapeId, createdAt, videoUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GrapeImplCopyWith<_$GrapeImpl> get copyWith =>
      __$$GrapeImplCopyWithImpl<_$GrapeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GrapeImplToJson(
      this,
    );
  }
}

abstract class _Grape implements Grape {
  const factory _Grape(
      {required final String grapeId,
      required final DateTime createdAt,
      final String? videoUrl}) = _$GrapeImpl;

  factory _Grape.fromJson(Map<String, dynamic> json) = _$GrapeImpl.fromJson;

  @override
  String get grapeId;
  @override
  DateTime get createdAt;
  @override
  String? get videoUrl;
  @override
  @JsonKey(ignore: true)
  _$$GrapeImplCopyWith<_$GrapeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
