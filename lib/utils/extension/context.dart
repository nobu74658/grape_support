import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grape_support/primary/show_dialog.dart';
import 'package:grape_support/utils/exception/error_message.dart';

extension ContextExtension on BuildContext {
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get bottomSafeArea => MediaQuery.of(this).padding.bottom;
  double get topSafeArea => MediaQuery.of(this).padding.top;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  TextStyle get titleStyle => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get subtitleStyle => Theme.of(this).textTheme.titleMedium!;
  TextStyle get bodyStyle => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get smallStyle => Theme.of(this).textTheme.bodySmall!;
  TextStyle get verySmallStyle =>
      Theme.of(this).textTheme.bodySmall!.copyWith(fontSize: 10);
  double get appBarHeight => MediaQuery.of(this).padding.top + kToolbarHeight;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  /// エラー処理
  Future<void> error({
    String? message,
    bool needVibration = false,
  }) async {
    if (needVibration) {
      unawaited(HapticFeedback.vibrate());
    }
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message ?? '不明なエラーです\nWifi環境をお確かめの上、もう一度実行して下さい',
        ),
      ),
    );
  }

  Future<void> errorDialog(Object? e) async {
    unawaited(
      SD.oneChoiceAlert(
        context: this,
        titleText: 'エラー',
        contentText: e == null ? EM.primaryError.toString() : e.toString(),
      ),
    );
  }
}
