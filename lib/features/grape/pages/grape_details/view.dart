import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/features/grape/pages/grape_details/view_model.dart';
import 'package:grape_support/primary/primary_when_widget.dart';
import 'package:grape_support/utils/constants/padding.dart';

class GrapeDetailsPage extends ConsumerWidget {
  const GrapeDetailsPage({
    required this.grapeId,
    super.key,
  });

  static const path = '/grape-details';

  final String grapeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(grapeDetailsViewModelProvider(grapeId));

    return state.when(
      error: (err, stack) => PrimaryWhenWidget(
        whenType: WhenType.error,
        errorMessage: err.toString(),
      ),
      loading: () => const PrimaryWhenWidget(whenType: WhenType.loading),
      data: (data) => Scaffold(
        appBar: AppBar(
          title: const Text('GrapeDetailsPage'),
        ),
        body: Column(
          children: [
            Text('grapeId: ${data.grape.grapeId}'),
            const SizedBox(height: PaddingStyle.p8),
            if (data.grape.videoUrl != null)
              ElevatedButton(
                onPressed: () {
                  unawaited(
                    context.push(
                      '/watch-video/${data.grape.grapeId}',
                    ),
                  );
                },
                child: const Text('動画を確認'),
              ),
          ],
        ),
      ),
    );
  }
}
