import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends ConsumerStatefulWidget {
  const QRCodeScreen({super.key});

  @override
  ConsumerState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends ConsumerState<QRCodeScreen> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Future<void> reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    await controller.resumeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double scanArea = 150;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QRコードをスキャン',
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: QRView(
                key: qrKey,
                overlay: QrScannerOverlayShape(
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea * 1.5,
                ),
                onQRViewCreated: (controller) =>
                    _onQRViewCreated(controller, context, ref),
                onPermissionSet: (ctrl, permission) async => _onPermissionSet(
                  context,
                  permission,
                ),
              ),
            ),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'QRコードをスキャンしてください。',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(
    QRViewController controller,
    BuildContext context,
    WidgetRef ref,
  ) {
    setState(() {
      this.controller = controller;
    });

    /// QRコードを読み取りをリッスンして処理を走らせる
    controller.scannedDataStream.listen((scanData) async {
      controller.dispose();
      final String? data = scanData.code;

      debugPrint(data);
    });
  }

  Future<void> _onPermissionSet(BuildContext context, bool permission) async {
    // 許可されなかった場合は、アラートを表示
    if (!permission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('カメラの使用を許可しないと、QRコードを読み取ることができません。'),
        ),
      );
    }
  }
}
