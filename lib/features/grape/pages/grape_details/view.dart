import 'package:flutter/material.dart';

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
        body: Center(
          child: Text('grapeId: $grapeId'),
        ),
      );
}
