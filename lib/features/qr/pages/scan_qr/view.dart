import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/features/grape/pages/grape_details/view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends ConsumerStatefulWidget {
  const ScanQrPage({super.key});

  static const path = '/scan-qr';

  @override
  ConsumerState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends ConsumerState<ScanQrPage> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
      body: Column(
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
              onPermissionSet: (ctrl, permission) async =>
                  _onPermissionSet(context, permission),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _onQRViewCreated(
    QRViewController controller,
    BuildContext context,
    WidgetRef ref,
  ) {
    setState(() => this.controller = controller);

    /// QRコードを読み取りをリッスンして処理を走らせる
    controller.scannedDataStream.listen((scanData) async {
      unawaited(controller.pauseCamera());
      final String? data = scanData.code;
      debugPrint(data);

      context.pushReplacement('${GrapeDetailsPage.path}/$data');
    });
  }

  Future<void> _onPermissionSet(BuildContext context, bool permission) async {
    // カメラの使用を許可されなかった場合は、アラートを表示
    if (!permission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('カメラの使用を許可しないと、QRコードを読み取ることができません。'),
        ),
      );
    }
  }
}
