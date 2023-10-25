import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/features/grape/pages/grape_list/view.dart';
import 'package:grape_support/features/qr/pages/create_qr/view.dart';
import 'package:grape_support/features/qr/pages/scan_qr/view.dart';
import 'package:grape_support/features/video/pages/watch_video/view.dart';
import 'package:grape_support/utils/constants/padding.dart';

enum NextPageType {
  createQR(CreateQrPage.path, 'QRコード作成', Icons.qr_code),
  scanQR(ScanQrPage.path, 'QRコード読み取り', Icons.camera_alt_outlined),
  grapeList(GrapeListPage.path, '一覧表示', Icons.list),
  whatchVideo(WatchVideoScreen.path, '動画視聴', Icons.video_library);

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
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/imp-grape-support.appspot.com/o/videos%2Fgrapes%2FIMG_6935.PNG?alt=media&token=8bd55e44-068e-4327-be7f-500db304ce79'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
}
