// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VideoState {
  Grape get grape => throw _privateConstructorUsedError;
  VideoPlayerController get controller => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VideoStateCopyWith<VideoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoStateCopyWith<$Res> {
  factory $VideoStateCopyWith(
          VideoState value, $Res Function(VideoState) then) =
      _$VideoStateCopyWithImpl<$Res, VideoState>;
  @useResult
  $Res call({Grape grape, VideoPlayerController controller});

  $GrapeCopyWith<$Res> get grape;
}

/// @nodoc
class _$VideoStateCopyWithImpl<$Res, $Val extends VideoState>
    implements $VideoStateCopyWith<$Res> {
  _$VideoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grape = null,
    Object? controller = null,
  }) {
    return _then(_value.copyWith(
      grape: null == grape
          ? _value.grape
          : grape // ignore: cast_nullable_to_non_nullable
              as Grape,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GrapeCopyWith<$Res> get grape {
    return $GrapeCopyWith<$Res>(_value.grape, (value) {
      return _then(_value.copyWith(grape: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VideoStateImplCopyWith<$Res>
    implements $VideoStateCopyWith<$Res> {
  factory _$$VideoStateImplCopyWith(
          _$VideoStateImpl value, $Res Function(_$VideoStateImpl) then) =
      __$$VideoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Grape grape, VideoPlayerController controller});

  @override
  $GrapeCopyWith<$Res> get grape;
}

/// @nodoc
class __$$VideoStateImplCopyWithImpl<$Res>
    extends _$VideoStateCopyWithImpl<$Res, _$VideoStateImpl>
    implements _$$VideoStateImplCopyWith<$Res> {
  __$$VideoStateImplCopyWithImpl(
      _$VideoStateImpl _value, $Res Function(_$VideoStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grape = null,
    Object? controller = null,
  }) {
    return _then(_$VideoStateImpl(
      grape: null == grape
          ? _value.grape
          : grape // ignore: cast_nullable_to_non_nullable
              as Grape,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController,
    ));
  }
}

/// @nodoc

class _$VideoStateImpl implements _VideoState {
  const _$VideoStateImpl({required this.grape, required this.controller});

  @override
  final Grape grape;
  @override
  final VideoPlayerController controller;

  @override
  String toString() {
    return 'VideoState(grape: $grape, controller: $controller)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStateImpl &&
            (identical(other.grape, grape) || other.grape == grape) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, grape, controller);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoStateImplCopyWith<_$VideoStateImpl> get copyWith =>
      __$$VideoStateImplCopyWithImpl<_$VideoStateImpl>(this, _$identity);
}

abstract class _VideoState implements VideoState {
  const factory _VideoState(
      {required final Grape grape,
      required final VideoPlayerController controller}) = _$VideoStateImpl;

  @override
  Grape get grape;
  @override
  VideoPlayerController get controller;
  @override
  @JsonKey(ignore: true)
  _$$VideoStateImplCopyWith<_$VideoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
