import 'package:flutter/material.dart';
import 'package:grape_support/utils/constants/padding.dart';
import 'package:grape_support/utils/extension/context.dart';

class BottomElevatedButton extends StatelessWidget {
  const BottomElevatedButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(
          PaddingStyle.p16,
          PaddingStyle.p8,
          PaddingStyle.p16,
          PaddingStyle.p8 + context.bottomSafeArea,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
        ),
      );
}
