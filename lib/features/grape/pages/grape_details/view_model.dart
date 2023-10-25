import 'package:grape_support/domain/grape/domain.dart';
import 'package:grape_support/features/grape/pages/grape_details/state.dart';
import 'package:grape_support/repositories/grape/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class GrapeDetailsViewModel extends _$GrapeDetailsViewModel {
  @override
  Future<GrapeDetailsState> build(String grapeId) async {
    final repo = ref.read(grapeRepoProvider.notifier);
    final Grape grape = await repo.getDoc(grapeId);

    return GrapeDetailsState(grape: grape);
  }
}
