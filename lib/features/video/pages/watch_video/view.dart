import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/features/video/components/video_player_widget.dart';
import 'package:grape_support/features/video/pages/watch_video/view_model.dart';
import 'package:grape_support/primary/primary_when_widget.dart';

class WatchVideoScreen extends ConsumerWidget {
  const WatchVideoScreen({
    required this.videoUrl,
    super.key,
  });

  static const path = '/watch-video';

  final String videoUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoViewModelProvider(videoUrl));

    return state.when(
      error: (err, stack) => PrimaryWhenWidget(
        whenType: WhenType.error,
        errorMessage: err.toString(),
      ),
      loading: () => const PrimaryWhenWidget(whenType: WhenType.loading),
      data: (data) => Scaffold(
        appBar: AppBar(),
        body: VideoPlayerWidget(controller: data.controller!),
      ),
    );
  }
}
