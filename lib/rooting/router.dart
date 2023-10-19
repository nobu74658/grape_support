import 'package:go_router/go_router.dart';
import 'package:grape_support/features/auth/pages/entrance/view.dart';
import 'package:grape_support/features/grape/pages/grape_details/view.dart';
import 'package:grape_support/features/grape/pages/grape_list/view.dart';
import 'package:grape_support/features/qr/pages/create_qr/view.dart';
import 'package:grape_support/features/qr/pages/scan_qr/view.dart';
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
              path: GrapeListPage.path.deleteSlash,
              builder: (context, state) => const GrapeListPage(),
            ),
            GoRoute(
              path: '${GrapeDetailsPage.path.deleteSlash}/:${Keys.grapeId}',
              builder: (context, state) => GrapeDetailsPage(
                grapeId: state.pathParameters[Keys.grapeId] ?? '',
              ),
            ),

            /// qr
            GoRoute(
              path: CreateQrPage.path.deleteSlash,
              builder: (context, state) => const CreateQrPage(),
            ),
            GoRoute(
              path: ScanQrPage.path.deleteSlash,
              builder: (context, state) => const ScanQrPage(),
            ),
          ],
        ),
      ],
    );
