import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grape_support/services/cache_manager.dart';

/// キャッシュ初期化を待つラッパーWidget
class CacheAwareWrapper extends ConsumerStatefulWidget {
  const CacheAwareWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  ConsumerState<CacheAwareWrapper> createState() => _CacheAwareWrapperState();
}

class _CacheAwareWrapperState extends ConsumerState<CacheAwareWrapper> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initializeCache());
  }

  Future<void> _initializeCache() async {
    if (_isInitialized) {
      return;
    }

    try {
      final cacheManager = ref.read(cacheManagerProvider.notifier);
      await cacheManager.initializeCache();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } on Exception catch (e) {
      debugPrint('❌ Cache initialization failed in wrapper: $e');
      // エラーが発生してもUIを表示
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'キャッシュ初期化中...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}
