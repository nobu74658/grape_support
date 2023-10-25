// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$grapeDetailsViewModelHash() =>
    r'1dd232439d28e26bc4d3cd4ef965d670b881b3e8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$GrapeDetailsViewModel
    extends BuildlessAutoDisposeAsyncNotifier<GrapeDetailsState> {
  late final String grapeId;

  Future<GrapeDetailsState> build(
    String grapeId,
  );
}

/// See also [GrapeDetailsViewModel].
@ProviderFor(GrapeDetailsViewModel)
const grapeDetailsViewModelProvider = GrapeDetailsViewModelFamily();

/// See also [GrapeDetailsViewModel].
class GrapeDetailsViewModelFamily
    extends Family<AsyncValue<GrapeDetailsState>> {
  /// See also [GrapeDetailsViewModel].
  const GrapeDetailsViewModelFamily();

  /// See also [GrapeDetailsViewModel].
  GrapeDetailsViewModelProvider call(
    String grapeId,
  ) {
    return GrapeDetailsViewModelProvider(
      grapeId,
    );
  }

  @override
  GrapeDetailsViewModelProvider getProviderOverride(
    covariant GrapeDetailsViewModelProvider provider,
  ) {
    return call(
      provider.grapeId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'grapeDetailsViewModelProvider';
}

/// See also [GrapeDetailsViewModel].
class GrapeDetailsViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GrapeDetailsViewModel,
        GrapeDetailsState> {
  /// See also [GrapeDetailsViewModel].
  GrapeDetailsViewModelProvider(
    String grapeId,
  ) : this._internal(
          () => GrapeDetailsViewModel()..grapeId = grapeId,
          from: grapeDetailsViewModelProvider,
          name: r'grapeDetailsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$grapeDetailsViewModelHash,
          dependencies: GrapeDetailsViewModelFamily._dependencies,
          allTransitiveDependencies:
              GrapeDetailsViewModelFamily._allTransitiveDependencies,
          grapeId: grapeId,
        );

  GrapeDetailsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.grapeId,
  }) : super.internal();

  final String grapeId;

  @override
  Future<GrapeDetailsState> runNotifierBuild(
    covariant GrapeDetailsViewModel notifier,
  ) {
    return notifier.build(
      grapeId,
    );
  }

  @override
  Override overrideWith(GrapeDetailsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: GrapeDetailsViewModelProvider._internal(
        () => create()..grapeId = grapeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        grapeId: grapeId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GrapeDetailsViewModel,
      GrapeDetailsState> createElement() {
    return _GrapeDetailsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GrapeDetailsViewModelProvider && other.grapeId == grapeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, grapeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GrapeDetailsViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<GrapeDetailsState> {
  /// The parameter `grapeId` of this provider.
  String get grapeId;
}

class _GrapeDetailsViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GrapeDetailsViewModel,
        GrapeDetailsState> with GrapeDetailsViewModelRef {
  _GrapeDetailsViewModelProviderElement(super.provider);

  @override
  String get grapeId => (origin as GrapeDetailsViewModelProvider).grapeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
