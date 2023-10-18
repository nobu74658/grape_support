import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/features/qr/pages/create_qr/view_model.dart';
import 'package:grape_support/primary/primary_when_widget.dart';
import 'package:printing/printing.dart';

class QrScreen extends ConsumerWidget {
  const QrScreen({super.key});

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
        appBar: AppBar(),
        body: Center(
          child: PdfPreview(
            build: (format) async => data.save(),
          ),
        ),
      ),
    );
  }
}
