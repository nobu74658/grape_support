// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$grapeCollectionHash() => r'f3e9136b6112e40bc29a0a61898d240ece09b5c6';

/// See also [grapeCollection].
@ProviderFor(grapeCollection)
final grapeCollectionProvider =
    Provider<CollectionReference<Map<String, dynamic>>>.internal(
  grapeCollection,
  name: r'grapeCollectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$grapeCollectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GrapeCollectionRef
    = ProviderRef<CollectionReference<Map<String, dynamic>>>;
String _$grapeRepoHash() => r'483e66e507db897992651e5fd7e95fdcb2fac388';

/// See also [GrapeRepo].
@ProviderFor(GrapeRepo)
final grapeRepoProvider = NotifierProvider<GrapeRepo, void>.internal(
  GrapeRepo.new,
  name: r'grapeRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$grapeRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GrapeRepo = Notifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
