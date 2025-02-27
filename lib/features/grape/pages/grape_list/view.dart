import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grape_support/domain/grape/domain.dart';
import 'package:grape_support/features/app/grapes_state.dart';
import 'package:grape_support/features/grape/pages/grape_details/view.dart';

class ConnectedGrapeListPage extends ConsumerWidget {
  const ConnectedGrapeListPage({super.key});

  static const path = '/grapes';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(grapesStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('一覧'),
      ),
      body: state.when(
        error: (err, stackTrace) =>
            const Scaffold(body: Center(child: Text('Error: err'))),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        data: (data) => GrapeListPage(grapes: data),
      ),
    );
  }
}

class GrapeListPage extends ConsumerWidget {
  const GrapeListPage({required this.grapes, super.key});

  final List<Grape> grapes;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        body: CustomMaterialIndicator(
          trigger: IndicatorTrigger.trailingEdge,
          onRefresh: () async {
            final state = ref.read(grapesStateProvider.notifier);
            await state.loadMore();
          },
          child: ListView.builder(
            itemCount: grapes.length,
            itemBuilder: (context, index) => ListTile(
              title: Text('grape $index'),
              onTap: () async => context
                  .push('${GrapeDetailsPage.path}/${grapes[index].grapeId}'),
            ),
          ),
        ),
      );
}
