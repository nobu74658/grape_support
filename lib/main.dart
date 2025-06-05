import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/cache_verification.dart';
import 'package:grape_support/debug_cache_location.dart';
import 'package:grape_support/firebase_options.dart';
import 'package:grape_support/rooting/router.dart';
import 'package:grape_support/services/cache_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await availableCameras();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _cacheInitialized = false;

  @override
  void initState() {
    super.initState();
    // アプリ起動時にキャッシュを初期化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_initializeCache());
    });
  }

  Future<void> _initializeCache() async {
    if (_cacheInitialized) {
      return;
    }

    try {
      final cacheManager = ref.read(cacheManagerProvider.notifier);
      await cacheManager.initializeCache();
      debugPrint('🎬 Cache initialized successfully');

      // キャッシュディレクトリの状態を確認
      debugPrint('🔍 Verifying cache directory state...');
      await CacheVerification.checkCacheDirectory();

      // キャッシュ場所の詳細表示
      await CacheLocationDebugger.showCacheLocation();
      CacheLocationDebugger.explainCacheNaming();
      CacheLocationDebugger.explainCacheSettings();

      _cacheInitialized = true;

      // 状態更新を通知
      if (mounted) {
        setState(() {});
      }
    } on Exception catch (e) {
      debugPrint('❌ Cache initialization failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
