// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$videoViewModelHash() => r'5acc567b82a36df31c31ce55ec3c262ff66a0d00';

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

abstract class _$VideoViewModel
    extends BuildlessAutoDisposeAsyncNotifier<VideoState> {
  late final String grapeId;

  FutureOr<VideoState> build(
    String grapeId,
  );
}

/// See also [VideoViewModel].
@ProviderFor(VideoViewModel)
const videoViewModelProvider = VideoViewModelFamily();

/// See also [VideoViewModel].
class VideoViewModelFamily extends Family<AsyncValue<VideoState>> {
  /// See also [VideoViewModel].
  const VideoViewModelFamily();

  /// See also [VideoViewModel].
  VideoViewModelProvider call(
    String grapeId,
  ) {
    return VideoViewModelProvider(
      grapeId,
    );
  }

  @override
  VideoViewModelProvider getProviderOverride(
    covariant VideoViewModelProvider provider,
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
  String? get name => r'videoViewModelProvider';
}

/// See also [VideoViewModel].
class VideoViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<VideoViewModel, VideoState> {
  /// See also [VideoViewModel].
  VideoViewModelProvider(
    String grapeId,
  ) : this._internal(
          () => VideoViewModel()..grapeId = grapeId,
          from: videoViewModelProvider,
          name: r'videoViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$videoViewModelHash,
          dependencies: VideoViewModelFamily._dependencies,
          allTransitiveDependencies:
              VideoViewModelFamily._allTransitiveDependencies,
          grapeId: grapeId,
        );

  VideoViewModelProvider._internal(
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
  FutureOr<VideoState> runNotifierBuild(
    covariant VideoViewModel notifier,
  ) {
    return notifier.build(
      grapeId,
    );
  }

  @override
  Override overrideWith(VideoViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: VideoViewModelProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<VideoViewModel, VideoState>
      createElement() {
    return _VideoViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VideoViewModelProvider && other.grapeId == grapeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, grapeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin VideoViewModelRef on AutoDisposeAsyncNotifierProviderRef<VideoState> {
  /// The parameter `grapeId` of this provider.
  String get grapeId;
}

class _VideoViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<VideoViewModel, VideoState>
    with VideoViewModelRef {
  _VideoViewModelProviderElement(super.provider);

  @override
  String get grapeId => (origin as VideoViewModelProvider).grapeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
