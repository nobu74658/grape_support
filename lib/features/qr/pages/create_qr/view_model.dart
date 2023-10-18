import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class CreateQrViewModel extends _$CreateQrViewModel {
  @override
  Future<pw.Document> build() async => createQrCode();

  Future<pw.Document> createQrCode() async {
    final pdf = pw.Document(author: 'imp');
    const double qrCodeSize = PdfPageFormat.cm * 5;

    final qrCode = pw.BarcodeWidget(
      barcode: pw.Barcode.qrCode(),
      data: 'grapeTestId',
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
}
