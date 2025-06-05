import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/features/video/components/app_video_progress_indicator.dart';
import 'package:grape_support/models/video_cache_model.dart';
import 'package:grape_support/services/video_cache_service.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends ConsumerStatefulWidget {
  const VideoTile({
    required this.controller,
    this.grapeId,
    super.key,
  });
  final VideoPlayerController controller;
  final String? grapeId;

  @override
  ConsumerState<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends ConsumerState<VideoTile> {
  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoPlayer(widget.controller),
          AppVideoProgressIndicator(
            widget.controller,
            padding: const EdgeInsets.only(bottom: 40),
            allowScrubbing: true,
            progressBarHeight: 10,
          ),
          Align(
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget.controller.value.isPlaying
                      ? unawaited(widget.controller.pause())
                      : unawaited(widget.controller.play());
                });
              },
              icon: Icon(
                widget.controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          // キャッシュ状態インジケーター
          if (widget.grapeId != null)
            Positioned(
              top: 8,
              right: 8,
              child: _buildCacheIndicator(widget.grapeId!),
            ),
        ],
      );

  /// キャッシュ状態インジケーター
  Widget _buildCacheIndicator(String grapeId) {
    final cacheState = ref.watch(videoCacheServiceProvider);
    final cacheModel = cacheState[grapeId];

    if (cacheModel?.status != CacheStatus.cached) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.offline_pin,
            color: Colors.white,
            size: 12,
          ),
          SizedBox(width: 2),
          Text(
            'オフライン',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
