import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pdf/widgets.dart';

part 'state.freezed.dart';

@freezed
abstract class CreateQRState with _$CreateQRState {
  const factory CreateQRState({
    required Document pdf,
    required String grapeId,
  }) = _CreateQRState;
}
