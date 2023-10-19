import 'package:flutter/material.dart';
import 'package:grape_support/utils/constants/padding.dart';

class GrapeDetailsPage extends StatelessWidget {
  const GrapeDetailsPage({
    required this.grapeId,
    super.key,
  });

  static const path = '/grape-details';

  final String grapeId;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('GrapeDetailsPage'),
        ),
        body: Column(
          children: [
            Text('grapeId: $grapeId'),
            const SizedBox(height: PaddingStyle.p8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('動画を確認'),
            ),
          ],
        ),
      );
}
