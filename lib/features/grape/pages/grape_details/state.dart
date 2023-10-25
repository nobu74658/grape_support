import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grape_support/domain/grape/domain.dart';

part 'state.freezed.dart';

@freezed
abstract class GrapeDetailsState with _$GrapeDetailsState {
  const factory GrapeDetailsState({
    required Grape grape,
  }) = _GrapeDetailsState;
}
