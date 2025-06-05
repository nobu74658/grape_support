// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isVideoCachedHash() => r'b56754d0a47b90af03367003bd4f87c66b295c63';

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

/// See also [isVideoCached].
@ProviderFor(isVideoCached)
const isVideoCachedProvider = IsVideoCachedFamily();

/// See also [isVideoCached].
class IsVideoCachedFamily extends Family<bool> {
  /// See also [isVideoCached].
  const IsVideoCachedFamily();

  /// See also [isVideoCached].
  IsVideoCachedProvider call(
    String grapeId,
  ) {
    return IsVideoCachedProvider(
      grapeId,
    );
  }

  @override
  IsVideoCachedProvider getProviderOverride(
    covariant IsVideoCachedProvider provider,
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
  String? get name => r'isVideoCachedProvider';
}

/// See also [isVideoCached].
class IsVideoCachedProvider extends AutoDisposeProvider<bool> {
  /// See also [isVideoCached].
  IsVideoCachedProvider(
    String grapeId,
  ) : this._internal(
          (ref) => isVideoCached(
            ref as IsVideoCachedRef,
            grapeId,
          ),
          from: isVideoCachedProvider,
          name: r'isVideoCachedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isVideoCachedHash,
          dependencies: IsVideoCachedFamily._dependencies,
          allTransitiveDependencies:
              IsVideoCachedFamily._allTransitiveDependencies,
          grapeId: grapeId,
        );

  IsVideoCachedProvider._internal(
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
  Override overrideWith(
    bool Function(IsVideoCachedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsVideoCachedProvider._internal(
        (ref) => create(ref as IsVideoCachedRef),
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
  AutoDisposeProviderElement<bool> createElement() {
    return _IsVideoCachedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsVideoCachedProvider && other.grapeId == grapeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, grapeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsVideoCachedRef on AutoDisposeProviderRef<bool> {
  /// The parameter `grapeId` of this provider.
  String get grapeId;
}

class _IsVideoCachedProviderElement extends AutoDisposeProviderElement<bool>
    with IsVideoCachedRef {
  _IsVideoCachedProviderElement(super.provider);

  @override
  String get grapeId => (origin as IsVideoCachedProvider).grapeId;
}

String _$videoCacheStatusHash() => r'11869f5f8965de8424d38be06fd72892de1b1c32';

/// See also [videoCacheStatus].
@ProviderFor(videoCacheStatus)
const videoCacheStatusProvider = VideoCacheStatusFamily();

/// See also [videoCacheStatus].
class VideoCacheStatusFamily extends Family<CacheStatus?> {
  /// See also [videoCacheStatus].
  const VideoCacheStatusFamily();

  /// See also [videoCacheStatus].
  VideoCacheStatusProvider call(
    String grapeId,
  ) {
    return VideoCacheStatusProvider(
      grapeId,
    );
  }

  @override
  VideoCacheStatusProvider getProviderOverride(
    covariant VideoCacheStatusProvider provider,
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
  String? get name => r'videoCacheStatusProvider';
}

/// See also [videoCacheStatus].
class VideoCacheStatusProvider extends AutoDisposeProvider<CacheStatus?> {
  /// See also [videoCacheStatus].
  VideoCacheStatusProvider(
    String grapeId,
  ) : this._internal(
          (ref) => videoCacheStatus(
            ref as VideoCacheStatusRef,
            grapeId,
          ),
          from: videoCacheStatusProvider,
          name: r'videoCacheStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$videoCacheStatusHash,
          dependencies: VideoCacheStatusFamily._dependencies,
          allTransitiveDependencies:
              VideoCacheStatusFamily._allTransitiveDependencies,
          grapeId: grapeId,
        );

  VideoCacheStatusProvider._internal(
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
  Override overrideWith(
    CacheStatus? Function(VideoCacheStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VideoCacheStatusProvider._internal(
        (ref) => create(ref as VideoCacheStatusRef),
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
  AutoDisposeProviderElement<CacheStatus?> createElement() {
    return _VideoCacheStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VideoCacheStatusProvider && other.grapeId == grapeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, grapeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin VideoCacheStatusRef on AutoDisposeProviderRef<CacheStatus?> {
  /// The parameter `grapeId` of this provider.
  String get grapeId;
}

class _VideoCacheStatusProviderElement
    extends AutoDisposeProviderElement<CacheStatus?> with VideoCacheStatusRef {
  _VideoCacheStatusProviderElement(super.provider);

  @override
  String get grapeId => (origin as VideoCacheStatusProvider).grapeId;
}

String _$videoDownloadProgressHash() =>
    r'77cd3b670b506028057f969ba3d18ebcddab67e9';

/// See also [videoDownloadProgress].
@ProviderFor(videoDownloadProgress)
const videoDownloadProgressProvider = VideoDownloadProgressFamily();

/// See also [videoDownloadProgress].
class VideoDownloadProgressFamily extends Family<double?> {
  /// See also [videoDownloadProgress].
  const VideoDownloadProgressFamily();

  /// See also [videoDownloadProgress].
  VideoDownloadProgressProvider call(
    String grapeId,
  ) {
    return VideoDownloadProgressProvider(
      grapeId,
    );
  }

  @override
  VideoDownloadProgressProvider getProviderOverride(
    covariant VideoDownloadProgressProvider provider,
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
  String? get name => r'videoDownloadProgressProvider';
}

/// See also [videoDownloadProgress].
class VideoDownloadProgressProvider extends AutoDisposeProvider<double?> {
  /// See also [videoDownloadProgress].
  VideoDownloadProgressProvider(
    String grapeId,
  ) : this._internal(
          (ref) => videoDownloadProgress(
            ref as VideoDownloadProgressRef,
            grapeId,
          ),
          from: videoDownloadProgressProvider,
          name: r'videoDownloadProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$videoDownloadProgressHash,
          dependencies: VideoDownloadProgressFamily._dependencies,
          allTransitiveDependencies:
              VideoDownloadProgressFamily._allTransitiveDependencies,
          grapeId: grapeId,
        );

  VideoDownloadProgressProvider._internal(
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
  Override overrideWith(
    double? Function(VideoDownloadProgressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VideoDownloadProgressProvider._internal(
        (ref) => create(ref as VideoDownloadProgressRef),
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
  AutoDisposeProviderElement<double?> createElement() {
    return _VideoDownloadProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VideoDownloadProgressProvider && other.grapeId == grapeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, grapeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin VideoDownloadProgressRef on AutoDisposeProviderRef<double?> {
  /// The parameter `grapeId` of this provider.
  String get grapeId;
}

class _VideoDownloadProgressProviderElement
    extends AutoDisposeProviderElement<double?> with VideoDownloadProgressRef {
  _VideoDownloadProgressProviderElement(super.provider);

  @override
  String get grapeId => (origin as VideoDownloadProgressProvider).grapeId;
}

String _$videoCacheInfoHash() => r'62e6c73ec6f69e9ef0f36c85bc70f5bf72993eb8';

/// See also [videoCacheInfo].
@ProviderFor(videoCacheInfo)
const videoCacheInfoProvider = VideoCacheInfoFamily();

/// See also [videoCacheInfo].
class VideoCacheInfoFamily extends Family<String> {
  /// See also [videoCacheInfo].
  const VideoCacheInfoFamily();

  /// See also [videoCacheInfo].
  VideoCacheInfoProvider call(
    String grapeId,
  ) {
    return VideoCacheInfoProvider(
      grapeId,
    );
  }

  @override
  VideoCacheInfoProvider getProviderOverride(
    covariant VideoCacheInfoProvider provider,
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
  String? get name => r'videoCacheInfoProvider';
}

/// See also [videoCacheInfo].
class VideoCacheInfoProvider extends AutoDisposeProvider<String> {
  /// See also [videoCacheInfo].
  VideoCacheInfoProvider(
    String grapeId,
  ) : this._internal(
          (ref) => videoCacheInfo(
            ref as VideoCacheInfoRef,
            grapeId,
          ),
          from: videoCacheInfoProvider,
          name: r'videoCacheInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$videoCacheInfoHash,
          dependencies: VideoCacheInfoFamily._dependencies,
          allTransitiveDependencies:
              VideoCacheInfoFamily._allTransitiveDependencies,
          grapeId: grapeId,
        );

  VideoCacheInfoProvider._internal(
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
  Override overrideWith(
    String Function(VideoCacheInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VideoCacheInfoProvider._internal(
        (ref) => create(ref as VideoCacheInfoRef),
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
  AutoDisposeProviderElement<String> createElement() {
    return _VideoCacheInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VideoCacheInfoProvider && other.grapeId == grapeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, grapeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin VideoCacheInfoRef on AutoDisposeProviderRef<String> {
  /// The parameter `grapeId` of this provider.
  String get grapeId;
}

class _VideoCacheInfoProviderElement extends AutoDisposeProviderElement<String>
    with VideoCacheInfoRef {
  _VideoCacheInfoProviderElement(super.provider);

  @override
  String get grapeId => (origin as VideoCacheInfoProvider).grapeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
