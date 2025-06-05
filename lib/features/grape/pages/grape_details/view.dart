import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/features/grape/pages/grape_details/view_model.dart';
import 'package:grape_support/features/qr/pages/create_qr/view_model.dart';
import 'package:grape_support/features/video/pages/take_video/view.dart';
import 'package:grape_support/primary/primary_when_widget.dart';
import 'package:grape_support/utils/constants/padding.dart';
import 'package:grape_support/utils/extension/context.dart';
import 'package:printing/printing.dart';

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
    final cardWidth = (context.deviceWidth - PaddingStyle.p16 * 3) / 2;

    // Create QR code asynchronously without awaiting
    unawaited(
      ref.read(createQRViewModelProvider.notifier).createQrCode(grapeId),
    );

    return state.when(
      error: (err, stack) => PrimaryWhenWidget(
        whenType: WhenType.error,
        errorMessage: err.toString(),
      ),
      loading: () => const PrimaryWhenWidget(whenType: WhenType.loading),
      data: (data) {
        final bool isVideoUrl = data.grape.videoUrl != null;

        return Scaffold(
          appBar: AppBar(
            title: const Text('GrapeDetailsPage'),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: PaddingStyle.p16),
            children: [
              Text('grapeId: ${data.grape.grapeId}'),
              const SizedBox(height: PaddingStyle.p8),
              Row(
                children: [
                  /// 動画を確認
                  GestureDetector(
                    onTap: isVideoUrl
                        ? () {
                            unawaited(
                              context.push(
                                '/watch-video/${data.grape.grapeId}',
                              ),
                            );
                          }
                        : null,
                    child: Card(
                      color: isVideoUrl ? null : ThemeData().disabledColor,
                      margin: EdgeInsets.zero,
                      child: SizedBox(
                        width: cardWidth,
                        height: cardWidth,
                        child: Center(
                          child: Text(
                            '動画を確認',
                            style: TextStyle(
                              color: isVideoUrl ? null : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: PaddingStyle.p16),

                  /// 動画を撮影
                  GestureDetector(
                    onTap: () {
                      unawaited(
                        context.push(
                          '${ConnectedTakeVideoScreen.path}/${data.grape.grapeId}',
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: SizedBox(
                        width: cardWidth,
                        height: cardWidth,
                        child: const Center(child: Text('動画を撮影')),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(PaddingStyle.p16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: PdfPreview(
                  build: (format) async => ref
                      .read(createQRViewModelProvider.notifier)
                      .createQrCode(grapeId)
                      .then((value) => value.save()),
                  allowPrinting: false,
                  allowSharing: false,
                  canChangePageFormat: false,
                  canChangeOrientation: false,
                  canDebug: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
