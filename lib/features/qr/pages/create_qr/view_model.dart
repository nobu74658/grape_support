import 'package:grape_support/features/qr/pages/create_qr/state.dart';
import 'package:grape_support/repositories/grape/repo.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'view_model.g.dart';

@riverpod
class CreateQrViewModel extends _$CreateQrViewModel {
  @override
  Future<CreateQrState> build() async {
    final grapeId = const Uuid().v4();
    final pdf = await createQrCode(grapeId);
    return CreateQrState(
      pdf: pdf,
      grapeId: grapeId,
    );
  }

  Future<Document> createQrCode(String grapeId) async {
    final pdf = Document(author: 'imp.grape');
    const double qrCodeSize = PdfPageFormat.cm * 5;

    final qrCode = pw.BarcodeWidget(
      barcode: pw.Barcode.qrCode(),
      data: grapeId,
      width: qrCodeSize,
      height: qrCodeSize,
    );

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(PdfPageFormat.cm * 0.2),
        pageFormat: const PdfPageFormat(qrCodeSize, qrCodeSize),
        build: (context) => qrCode,
      ),
    );

    return pdf;
  }

  Future<String> setGrape() async {
    final grapeId = state.requireValue.grapeId;
    await ref.read(grapeRepoProvider.notifier).create(grapeId);

    return grapeId;
  }
}
