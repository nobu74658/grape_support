import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SD {
  static Future<Future> alertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String yesButtonText,
    required VoidCallback? yesButtonPressed,
  }) async =>
      showDialog(
        context: context,
        builder: (_) {
          if (kIsWeb || Platform.isAndroid) {
            return AlertDialog(
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('いいえ'),
                ),
                Builder(
                  builder: (context) => TextButton(
                    onPressed: yesButtonPressed,
                    child: Text(yesButtonText),
                  ),
                ),
              ],
            );
          }

          return CupertinoAlertDialog(
            title: Text(title, textAlign: TextAlign.center),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'いいえ',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Builder(
                builder: (context) => CupertinoDialogAction(
                  onPressed: yesButtonPressed,
                  child: Text(yesButtonText),
                ),
              ),
            ],
          );
        },
      );

  static Future<void> oneChoiceAlert({
    required BuildContext context,
    required String titleText,
    required String contentText,
    String? oneText,
    VoidCallback? onPressed,
    bool needVibration = false,
  }) async {
    if (needVibration) {
      await HapticFeedback.vibrate();
    }
    if (context.mounted) {
      await showDialog(
        context: context,
        builder: (_) {
          if (kIsWeb || Platform.isAndroid) {
            return AlertDialog(
              title: Text(
                titleText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(contentText),
              actions: [
                TextButton(
                  onPressed: onPressed ?? () => Navigator.pop(context),
                  child: Text(oneText ?? '戻る'),
                ),
              ],
            );
          }

          return CupertinoAlertDialog(
            title: Text(titleText),
            content: Text(contentText),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: onPressed ?? () => Navigator.pop(context),
                child: Text(
                  oneText ?? '戻る',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  /// Circular表示
  static Future<void> circular(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration.zero, // これを入れると遅延を入れなくて済む
      barrierColor: Colors.black.withOpacity(0.25),
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) =>
          const Center(child: CircularProgressIndicator(color: Colors.blue)),
    );
  }

  static Future bottomSheet({
    required BuildContext context,
    required Widget child,
  }) =>
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        isScrollControlled: true,
        builder: (builder) => child,
      );
}
