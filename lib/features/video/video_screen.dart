import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/features/video/components/asset_player_widget.dart';
import 'package:grape_support/features/video/components/file_player_widget.dart';
import 'package:grape_support/features/video/components/network_player_widget.dart';
import 'package:grape_support/features/video/components/video_tile.dart';
import 'package:grape_support/features/video/video_view_model.dart';
import 'package:grape_support/primary/show_dialog.dart';

class VideoScreen extends ConsumerWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoViewModelProvider);
    final controller = ref.read(videoViewModelProvider.notifier);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('video demo'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.network_wifi),
                text: 'Network',
              ),
              Tab(
                icon: Icon(Icons.file_copy),
                text: 'File',
              ),
              Tab(
                icon: Icon(Icons.video_library),
                text: 'Asset',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const NetworkPlayerWidget(),
            const FilePlayerWidget(),
            AssetPlayerWidget(),
          ],
        ),
      ),
    );
  }
}
