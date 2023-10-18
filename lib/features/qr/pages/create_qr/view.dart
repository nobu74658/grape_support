import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/features/grape/pages/grape_details/view.dart';
import 'package:grape_support/features/qr/pages/create_qr/view_model.dart';
import 'package:grape_support/primary/bottom_elevated_button.dart';
import 'package:grape_support/primary/primary_when_widget.dart';
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
          build: (format) async => data.save(),
          allowPrinting: false,
          allowSharing: false,
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
        ),
        bottomNavigationBar: BottomElevatedButton(
          onPressed: () async {
            await ref
                .read(createQrViewModelProvider.notifier)
                .setGrape()
                .then((value) => context.push('${GrapeDetailsPage.path}/$value'));
          },
          child: const Text('登録する'),
        ),
      ),
    );
  }
}
