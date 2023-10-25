// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:grape_support/utils/constants/keys.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'repo.g.dart';

// @Riverpod(keepAlive: true)
// CollectionReference<Map<String, dynamic>> Collection(
//   ${2/(.*)/Collection ref,
// ) =>
//     ref.read(firestoreProvider).collection(Keys.collectionName);

// @Riverpod(keepAlive: true)
// class TestRepo extends _$TestRepo {
//   CollectionReference<Map<String, dynamic>> get _Collection =>
//       ref.read(CollectionProvider);
//   DbManager get _dbManager => ref.read(dbManagerProvider.notifier);
//   @override
//   void build() {}

//   Future<void> create(String itemId) async =>
//       _dbManager.set(_Collection.doc(itemId), {
//         'itemId': itemId,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
// }