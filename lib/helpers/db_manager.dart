import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grape_support/providers/firebase/firebase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_manager.g.dart';

@Riverpod(keepAlive: true)
class DbManager extends _$DbManager {
  FirebaseFirestore get _firestore => ref.read(firestoreProvider);

  @override
  void build() {}

  Future<void> set<T>(
    DocumentReference<T> documentReference,
    T data,
  ) async {
    final snapshot = await documentReference.get();
    if (snapshot.exists) {
      throw Exception('Document already exists');
    }
    await documentReference.set(data);
  }

  Future<void> update<T>(
    DocumentReference<T> documentReference,
    Map<String, dynamic> jsonData,
  ) async {
    final snapshot = await documentReference.get();
    if (!snapshot.exists) {
      throw Exception('Document does not exist');
    }
    await documentReference.update(jsonData);
  }

  Future<T> getDoc<T>(
    DocumentReference<T> documentReference,
  ) async {
    final snapshot = await documentReference.get();
    if (!snapshot.exists) {
      throw Exception('Document does not exist');
    }
    return snapshot.data()!;
  }

  Stream<DocumentSnapshot<T>> streamDoc<T>(
    DocumentReference<T> documentReference,
  ) =>
      documentReference.snapshots();

  Future<void> batch<T>(
    Function(WriteBatch batch) batchHandler,
  ) async {
    final batch = _firestore.batch();
    await batchHandler(batch);
    await batch.commit();
  }

  Future<void> transaction<T>(
    Future<void> Function(Transaction t) transactionHandler,
  ) async =>
      _firestore.runTransaction(transactionHandler);

  Future<List<T>> getData<T>(
    Query<T> query,
  ) async =>
      query.get().then((value) => value.docs.map((e) => e.data()).toList());

  Stream<QuerySnapshot<T>> streamData<T>(Query<T> query) => query.snapshots();
}
