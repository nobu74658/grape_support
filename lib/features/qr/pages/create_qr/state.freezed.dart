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
mixin _$CreateQrState {
  Document get pdf => throw _privateConstructorUsedError;
  String get grapeId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateQrStateCopyWith<CreateQrState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateQrStateCopyWith<$Res> {
  factory $CreateQrStateCopyWith(
          CreateQrState value, $Res Function(CreateQrState) then) =
      _$CreateQrStateCopyWithImpl<$Res, CreateQrState>;
  @useResult
  $Res call({Document pdf, String grapeId});
}

/// @nodoc
class _$CreateQrStateCopyWithImpl<$Res, $Val extends CreateQrState>
    implements $CreateQrStateCopyWith<$Res> {
  _$CreateQrStateCopyWithImpl(this._value, this._then);

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
abstract class _$$CreateQrStateImplCopyWith<$Res>
    implements $CreateQrStateCopyWith<$Res> {
  factory _$$CreateQrStateImplCopyWith(
          _$CreateQrStateImpl value, $Res Function(_$CreateQrStateImpl) then) =
      __$$CreateQrStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Document pdf, String grapeId});
}

/// @nodoc
class __$$CreateQrStateImplCopyWithImpl<$Res>
    extends _$CreateQrStateCopyWithImpl<$Res, _$CreateQrStateImpl>
    implements _$$CreateQrStateImplCopyWith<$Res> {
  __$$CreateQrStateImplCopyWithImpl(
      _$CreateQrStateImpl _value, $Res Function(_$CreateQrStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pdf = null,
    Object? grapeId = null,
  }) {
    return _then(_$CreateQrStateImpl(
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

class _$CreateQrStateImpl implements _CreateQrState {
  const _$CreateQrStateImpl({required this.pdf, required this.grapeId});

  @override
  final Document pdf;
  @override
  final String grapeId;

  @override
  String toString() {
    return 'CreateQrState(pdf: $pdf, grapeId: $grapeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateQrStateImpl &&
            (identical(other.pdf, pdf) || other.pdf == pdf) &&
            (identical(other.grapeId, grapeId) || other.grapeId == grapeId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pdf, grapeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateQrStateImplCopyWith<_$CreateQrStateImpl> get copyWith =>
      __$$CreateQrStateImplCopyWithImpl<_$CreateQrStateImpl>(this, _$identity);
}

abstract class _CreateQrState implements CreateQrState {
  const factory _CreateQrState(
      {required final Document pdf,
      required final String grapeId}) = _$CreateQrStateImpl;

  @override
  Document get pdf;
  @override
  String get grapeId;
  @override
  @JsonKey(ignore: true)
  _$$CreateQrStateImplCopyWith<_$CreateQrStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
