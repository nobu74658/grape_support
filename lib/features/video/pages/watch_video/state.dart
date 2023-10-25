import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grape_support/domain/grape/domain.dart';
import 'package:video_player/video_player.dart';

part 'state.freezed.dart';

@freezed
abstract class VideoState with _$VideoState {
  const factory VideoState({
    required Grape grape,
    required VideoPlayerController controller,
  }) = _VideoState;
}
