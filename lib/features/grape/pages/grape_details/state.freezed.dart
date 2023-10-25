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
mixin _$GrapeDetailsState {
  Grape get grape => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GrapeDetailsStateCopyWith<GrapeDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GrapeDetailsStateCopyWith<$Res> {
  factory $GrapeDetailsStateCopyWith(
          GrapeDetailsState value, $Res Function(GrapeDetailsState) then) =
      _$GrapeDetailsStateCopyWithImpl<$Res, GrapeDetailsState>;
  @useResult
  $Res call({Grape grape});

  $GrapeCopyWith<$Res> get grape;
}

/// @nodoc
class _$GrapeDetailsStateCopyWithImpl<$Res, $Val extends GrapeDetailsState>
    implements $GrapeDetailsStateCopyWith<$Res> {
  _$GrapeDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grape = null,
  }) {
    return _then(_value.copyWith(
      grape: null == grape
          ? _value.grape
          : grape // ignore: cast_nullable_to_non_nullable
              as Grape,
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
abstract class _$$GrapeDetailsStateImplCopyWith<$Res>
    implements $GrapeDetailsStateCopyWith<$Res> {
  factory _$$GrapeDetailsStateImplCopyWith(_$GrapeDetailsStateImpl value,
          $Res Function(_$GrapeDetailsStateImpl) then) =
      __$$GrapeDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Grape grape});

  @override
  $GrapeCopyWith<$Res> get grape;
}

/// @nodoc
class __$$GrapeDetailsStateImplCopyWithImpl<$Res>
    extends _$GrapeDetailsStateCopyWithImpl<$Res, _$GrapeDetailsStateImpl>
    implements _$$GrapeDetailsStateImplCopyWith<$Res> {
  __$$GrapeDetailsStateImplCopyWithImpl(_$GrapeDetailsStateImpl _value,
      $Res Function(_$GrapeDetailsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grape = null,
  }) {
    return _then(_$GrapeDetailsStateImpl(
      grape: null == grape
          ? _value.grape
          : grape // ignore: cast_nullable_to_non_nullable
              as Grape,
    ));
  }
}

/// @nodoc

class _$GrapeDetailsStateImpl implements _GrapeDetailsState {
  const _$GrapeDetailsStateImpl({required this.grape});

  @override
  final Grape grape;

  @override
  String toString() {
    return 'GrapeDetailsState(grape: $grape)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GrapeDetailsStateImpl &&
            (identical(other.grape, grape) || other.grape == grape));
  }

  @override
  int get hashCode => Object.hash(runtimeType, grape);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GrapeDetailsStateImplCopyWith<_$GrapeDetailsStateImpl> get copyWith =>
      __$$GrapeDetailsStateImplCopyWithImpl<_$GrapeDetailsStateImpl>(
          this, _$identity);
}

abstract class _GrapeDetailsState implements GrapeDetailsState {
  const factory _GrapeDetailsState({required final Grape grape}) =
      _$GrapeDetailsStateImpl;

  @override
  Grape get grape;
  @override
  @JsonKey(ignore: true)
  _$$GrapeDetailsStateImplCopyWith<_$GrapeDetailsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
