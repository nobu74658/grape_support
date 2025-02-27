import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/features/auth/pages/entrance/view.dart';
import 'package:grape_support/features/grape/pages/grape_details/view.dart';
import 'package:grape_support/features/grape/pages/grape_list/view.dart';
import 'package:grape_support/features/qr/pages/create_qr/view.dart';
import 'package:grape_support/features/qr/pages/scan_qr/view.dart';
import 'package:grape_support/features/video/pages/take_video/view.dart';
import 'package:grape_support/features/video/pages/watch_video/view.dart';
import 'package:grape_support/providers/camera/camera.dart';
import 'package:grape_support/utils/constants/keys.dart';
import 'package:grape_support/utils/extension/string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) => GoRouter(
      initialLocation: EntrancePage.path,
      routes: [
        GoRoute(
          path: EntrancePage.path,
          builder: (context, state) => const EntrancePage(),
          routes: [
            /// grape
            GoRoute(
              path: ConnectedGrapeListPage.path.deleteSlash,
              builder: (context, state) => const ConnectedGrapeListPage(),
            ),
            GoRoute(
              path: '${GrapeDetailsPage.path.deleteSlash}/:${Keys.grapeId}',
              builder: (context, state) => GrapeDetailsPage(
                grapeId: state.pathParameters[Keys.grapeId] ?? '',
              ),
            ),

            /// qr
            GoRoute(
              path: CreateQRPage.path.deleteSlash,
              builder: (context, state) => const CreateQRPage(),
            ),
            GoRoute(
              path: ScanQrPage.path.deleteSlash,
              builder: (context, state) => const ScanQrPage(),
            ),

            /// video
            GoRoute(
              path: '${ConnectedTakeVideoScreen.path.deleteSlash}/:${Keys.grapeId}',
              builder: (context, state) {
                if (state.pathParameters[Keys.grapeId] == null) {
                  throw Exception('grapeId is null');
                }
                return ConnectedTakeVideoScreen(
                  grapeId: state.pathParameters[Keys.grapeId]!,
                );
              },
            ),
            GoRoute(
              path: '${WatchVideoScreen.path.deleteSlash}/:${Keys.grapeId}',
              builder: (context, state) => WatchVideoScreen(
                videoUrl: state.pathParameters[Keys.grapeId] ?? '',
              ),
            ),
          ],
        ),
      ],
    );
