import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:grape_support/domain/grape/domain.dart';
import 'package:grape_support/helpers/db_manager.dart';
import 'package:grape_support/providers/firebase/firebase.dart';
import 'package:grape_support/utils/constants/keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repo.g.dart';

@Riverpod(keepAlive: true)
CollectionReference<Grape> grapeCollection(
  GrapeCollectionRef ref,
) =>
    ref.read(firestoreProvider).collection(Keys.grapeCollection).withConverter(
          fromFirestore: (snapshot, _) => Grape.fromJson(snapshot.data()!),
          toFirestore: (grape, _) => grape.toJson(),
        );

@Riverpod(keepAlive: true)
class GrapeRepo extends _$GrapeRepo {
  CollectionReference<Grape> get _grapeCollection =>
      ref.read(grapeCollectionProvider);
  DbManager get _dbManager => ref.read(dbManagerProvider.notifier);
  @override
  void build() {}

  Future<void> create(String grapeId) async => _dbManager.set(
        _grapeCollection.doc(grapeId),
        Grape(grapeId: grapeId, createdAt: DateTime.now()),
      );

  Future<Grape> getDoc(String grapeId) async {
    debugPrint('grapeId: $grapeId');
    return _dbManager.getDoc(_grapeCollection.doc(grapeId));
  }

  Stream<Grape> getDocStream(String grapeId) {
    final stream = _grapeCollection.doc(grapeId).snapshots().map(
          (snapshot) => snapshot.data()!,
        );
    print(stream.first);
    return stream;
  }
}
