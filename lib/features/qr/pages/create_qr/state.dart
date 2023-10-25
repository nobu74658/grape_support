import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pdf/widgets.dart';

part 'state.freezed.dart';

@freezed
abstract class CreateQrState with _$CreateQrState {
  const factory CreateQrState({
    required Document pdf,
    required String grapeId,
  }) = _CreateQrState;
}
