import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain.freezed.dart';
part 'domain.g.dart';

@freezed
class Grape with _$Grape {
  const factory Grape({
    required String grapeId,
    required DateTime createdAt,
    String? videoUrl,
  }) = _Grape;

  factory Grape.mock() => Grape(
        grapeId: 'grapeTestId',
        createdAt: DateTime.now(),
      );

  factory Grape.create(String grepeId) => Grape(
        grapeId: grepeId,
        createdAt: DateTime.now(),
      );

  factory Grape.fromJson(Map<String, dynamic> json) => _$GrapeFromJson(json);
}
