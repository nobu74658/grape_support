import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// video_player の ProgressIndicator は height が固定であるため、可変の Indicator を作成
class AppVideoProgressIndicator extends StatefulWidget {
  const AppVideoProgressIndicator(
    this.controller, {
    required this.allowScrubbing,
    super.key,
    this.colors = const VideoProgressColors(),
    this.padding = const EdgeInsets.only(top: 5),
    this.progressBarHeight,
  });

  final VideoPlayerController controller;
  final VideoProgressColors colors;
  final bool allowScrubbing;
  final EdgeInsets padding;
  final double? progressBarHeight;

  @override
  State<AppVideoProgressIndicator> createState() =>
      _VideoProgressIndicatorState();
}

class _VideoProgressIndicatorState extends State<AppVideoProgressIndicator> {
  _VideoProgressIndicatorState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  late VoidCallback listener;
  VideoPlayerController get controller => widget.controller;
  VideoProgressColors get colors => widget.colors;
  double? get _progressBarHeight => widget.progressBarHeight;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget progressIndicator;
    if (controller.value.isInitialized) {
      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;

      int maxBuffering = 0;
      for (final DurationRange range in controller.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      progressIndicator = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          LinearProgressIndicator(
            minHeight: _progressBarHeight,
            value: maxBuffering / duration,
            valueColor: AlwaysStoppedAnimation<Color>(colors.bufferedColor),
            backgroundColor: colors.backgroundColor,
          ),
          LinearProgressIndicator(
            minHeight: _progressBarHeight,
            value: position / duration,
            valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
            backgroundColor: Colors.transparent,
          ),
        ],
      );
    } else {
      progressIndicator = LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
        backgroundColor: colors.backgroundColor,
      );
    }
    final Widget paddedProgressIndicator = Padding(
      padding: widget.padding,
      child: progressIndicator,
    );
    if (widget.allowScrubbing) {
      return VideoScrubber(
        controller: controller,
        child: paddedProgressIndicator,
      );
    } else {
      return paddedProgressIndicator;
    }
  }
}
