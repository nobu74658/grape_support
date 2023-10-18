import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player/video_player.dart';

part 'state.freezed.dart';

@freezed
abstract class VideoState with _$VideoState {
  const factory VideoState({
    VideoPlayerController? controller,
  }) = _VideoState;
}
