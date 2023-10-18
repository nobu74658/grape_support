import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'view_model.g.dart';

@riverpod
class CreateQrViewModel extends _$CreateQrViewModel {
  @override
  Future<Document> build() async => createQrCode();

  Future<Document> createQrCode() async {
    final pdf = Document(author: 'imp');
    const double qrCodeSize = PdfPageFormat.cm * 5;

    final qrCode = pw.BarcodeWidget(
      barcode: pw.Barcode.qrCode(),
      data: const Uuid().v4(),
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
    final db = FirebaseFirestore.instance;
    final doc = db.collection('grapes').doc();

    await doc.set({
      'grapeId': doc.id,
      'name': 'test',
      'createdAt': DateTime.now(),
    });

    return doc.id;
  }
}
