import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grape_support/helpers/db_manager.dart';
import 'package:grape_support/providers/firebase/firebase.dart';
import 'package:grape_support/utils/constants/keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repo.g.dart';

@Riverpod(keepAlive: true)
CollectionReference<Map<String, dynamic>> grapeCollection(
  GrapeCollectionRef ref,
) =>
    ref.read(firestoreProvider).collection(Keys.grapeCollection);

@Riverpod(keepAlive: true)
class GrapeRepo extends _$GrapeRepo {
  CollectionReference<Map<String, dynamic>> get _grapeCollection =>
      ref.read(grapeCollectionProvider);
  DbManager get _dbManager => ref.read(dbManagerProvider.notifier);
  @override
  void build() {}

  Future<void> create(String grapeId) async =>
      _dbManager.set(_grapeCollection.doc(grapeId), {
        'grapeId': grapeId,
        'createdAt': FieldValue.serverTimestamp(),
      });
}
