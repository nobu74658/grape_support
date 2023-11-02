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
mixin _$CreateQRState {
  Document get pdf => throw _privateConstructorUsedError;
  String get grapeId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateQRStateCopyWith<CreateQRState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateQRStateCopyWith<$Res> {
  factory $CreateQRStateCopyWith(
          CreateQRState value, $Res Function(CreateQRState) then) =
      _$CreateQRStateCopyWithImpl<$Res, CreateQRState>;
  @useResult
  $Res call({Document pdf, String grapeId});
}

/// @nodoc
class _$CreateQRStateCopyWithImpl<$Res, $Val extends CreateQRState>
    implements $CreateQRStateCopyWith<$Res> {
  _$CreateQRStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pdf = null,
    Object? grapeId = null,
  }) {
    return _then(_value.copyWith(
      pdf: null == pdf
          ? _value.pdf
          : pdf // ignore: cast_nullable_to_non_nullable
              as Document,
      grapeId: null == grapeId
          ? _value.grapeId
          : grapeId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateQRStateImplCopyWith<$Res>
    implements $CreateQRStateCopyWith<$Res> {
  factory _$$CreateQRStateImplCopyWith(
          _$CreateQRStateImpl value, $Res Function(_$CreateQRStateImpl) then) =
      __$$CreateQRStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Document pdf, String grapeId});
}

/// @nodoc
class __$$CreateQRStateImplCopyWithImpl<$Res>
    extends _$CreateQRStateCopyWithImpl<$Res, _$CreateQRStateImpl>
    implements _$$CreateQRStateImplCopyWith<$Res> {
  __$$CreateQRStateImplCopyWithImpl(
      _$CreateQRStateImpl _value, $Res Function(_$CreateQRStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pdf = null,
    Object? grapeId = null,
  }) {
    return _then(_$CreateQRStateImpl(
      pdf: null == pdf
          ? _value.pdf
          : pdf // ignore: cast_nullable_to_non_nullable
              as Document,
      grapeId: null == grapeId
          ? _value.grapeId
          : grapeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateQRStateImpl implements _CreateQRState {
  const _$CreateQRStateImpl({required this.pdf, required this.grapeId});

  @override
  final Document pdf;
  @override
  final String grapeId;

  @override
  String toString() {
    return 'CreateQRState(pdf: $pdf, grapeId: $grapeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateQRStateImpl &&
            (identical(other.pdf, pdf) || other.pdf == pdf) &&
            (identical(other.grapeId, grapeId) || other.grapeId == grapeId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pdf, grapeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateQRStateImplCopyWith<_$CreateQRStateImpl> get copyWith =>
      __$$CreateQRStateImplCopyWithImpl<_$CreateQRStateImpl>(this, _$identity);
}

abstract class _CreateQRState implements CreateQRState {
  const factory _CreateQRState(
      {required final Document pdf,
      required final String grapeId}) = _$CreateQRStateImpl;

  @override
  Document get pdf;
  @override
  String get grapeId;
  @override
  @JsonKey(ignore: true)
  _$$CreateQRStateImplCopyWith<_$CreateQRStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
