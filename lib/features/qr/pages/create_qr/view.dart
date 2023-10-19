import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/features/grape/pages/grape_details/view.dart';
import 'package:grape_support/features/qr/pages/create_qr/view_model.dart';
import 'package:grape_support/primary/bottom_elevated_button.dart';
import 'package:grape_support/primary/primary_when_widget.dart';
import 'package:grape_support/primary/show_dialog.dart';
import 'package:printing/printing.dart';

class CreateQrPage extends ConsumerWidget {
  const CreateQrPage({super.key});

  static const path = '/create-qr';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createQrViewModelProvider);

    return state.when(
      error: (err, stack) => PrimaryWhenWidget(
        whenType: WhenType.errorWidget,
        errorMessage: err.toString(),
      ),
      loading: () => const PrimaryWhenWidget(whenType: WhenType.loadingWidget),
      data: (data) => Scaffold(
        appBar: AppBar(
          title: const Text('新規登録'),
        ),
        body: PdfPreview(
          build: (format) async => data.pdf.save(),
          allowPrinting: false,
          allowSharing: false,
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
        ),
        bottomNavigationBar: BottomElevatedButton(
          onPressed: () async => _onPressed(context, ref, data.grapeId),
          child: const Text('登録する'),
        ),
      ),
    );
  }

  Future<void> _onPressed(
      BuildContext context, WidgetRef ref, String grapeId) async {
    unawaited(SD.circular(context));
    await ref.read(createQrViewModelProvider.notifier).setGrape().then(
      (value) {
        context.pop(); // circular
        return context.push('${GrapeDetailsPage.path}/$grapeId');
      },
    );
  }
}
