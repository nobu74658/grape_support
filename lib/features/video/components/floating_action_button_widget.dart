import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    required this.onPressed, super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, size: 32),
      );
}
