import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/features/grape/pages/grape_list/view.dart';
import 'package:grape_support/features/qr/pages/create_qr/view.dart';
import 'package:grape_support/features/qr/pages/scan_qr/view.dart';
import 'package:grape_support/utils/constants/padding.dart';

enum NextPageType {
  createQR(CreateQRPage.path, 'QRコード作成', Icons.qr_code),
  scanQR(ScanQrPage.path, 'QRコード読み取り', Icons.camera_alt_outlined),
  grapeList(ConnectedGrapeListPage.path, '一覧表示', Icons.list);

  const NextPageType(
    this.path,
    this.title,
    this.icon,
  );

  final String path;
  final String title;
  final IconData icon;
}

class EntrancePage extends StatelessWidget {
  const EntrancePage({super.key});

  static const path = '/';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Entrance Page'),
        ),
        body: GridView(
          padding: const EdgeInsets.all(PaddingStyle.p16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: PaddingStyle.p8,
            mainAxisSpacing: PaddingStyle.p8,
          ),
          children: [
            for (final page in NextPageType.values.toList())
              InkWell(
                onTap: () async => context.push(page.path),
                child: Card(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(page.icon),
                        const SizedBox(height: PaddingStyle.p4),
                        Text(page.title),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
