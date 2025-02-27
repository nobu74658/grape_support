import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grape_support/domain/grape/domain.dart';
import 'package:grape_support/repositories/grape/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grapes_state.g.dart';

@riverpod
class GrapesState extends _$GrapesState {
  DocumentSnapshot<Grape>? _startAfter;

  @override
  Future<List<Grape>> build() async {
    final repo = ref.read(grapeRepoProvider.notifier);
    final result = await repo.getGrapeList(10, null);
    _startAfter = result.$2;
    return result.$1;
  }

  Future<void> loadMore() async {
    final repo = ref.read(grapeRepoProvider.notifier);
    final result = await repo.getGrapeList(10, _startAfter);
    _startAfter = result.$2;
    final grapes = state.requireValue;
    state = AsyncData([
      ...grapes,
      ...result.$1,
    ]);
  }
}
