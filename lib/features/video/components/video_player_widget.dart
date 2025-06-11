import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grape_support/features/video/components/app_video_progress_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    required this.controller,
    super.key,
  });
  final VideoPlayerController controller;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  Timer? _hideTimer;
  bool _showControls = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _showControlsTemporarily() {
    setState(() {
      _showControls = true;
    });
    _fadeController.forward();

    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        _fadeController.reverse().then((_) {
          if (mounted) {
            setState(() {
              _showControls = false;
            });
          }
        });
      }
    });
  }

  void _togglePlayPause() {
    if (widget.controller.value.isPlaying) {
      unawaited(widget.controller.pause());
    } else {
      unawaited(widget.controller.play());
    }
    _showControlsTemporarily();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _togglePlayPause,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: AspectRatio(
                    aspectRatio: widget.controller.value.aspectRatio,
                    child: VideoPlayer(widget.controller),
                  ),
                ),
                // 再生/一時停止状態を示すオーバーレイ
                AnimatedBuilder(
                  animation: widget.controller,
                  builder: (context, child) => AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) => Opacity(
                      opacity: _showControls
                          ? _fadeAnimation.value
                          : (!widget.controller.value.isPlaying ? 1.0 : 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          widget.controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            AppVideoProgressIndicator(
              widget.controller,
              progressBarHeight: 20,
              allowScrubbing: true,
            ),
          ],
        ),
      ),
    );
  }
}
