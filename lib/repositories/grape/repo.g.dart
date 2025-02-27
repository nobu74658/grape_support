// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$grapeCollectionHash() => r'1bf1b25b755a6b4e1ac6386ad485c0a7f3d19782';

/// See also [grapeCollection].
@ProviderFor(grapeCollection)
final grapeCollectionProvider = Provider<CollectionReference<Grape>>.internal(
  grapeCollection,
  name: r'grapeCollectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$grapeCollectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GrapeCollectionRef = ProviderRef<CollectionReference<Grape>>;
String _$grapeRepoHash() => r'1f3345afc885bdf5b260bb9fa47fd1c6d4464430';

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
