// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GrapeImpl _$$GrapeImplFromJson(Map<String, dynamic> json) => _$GrapeImpl(
      grapeId: json['grapeId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      videoUrl: json['videoUrl'] as String?,
    );

Map<String, dynamic> _$$GrapeImplToJson(_$GrapeImpl instance) =>
    <String, dynamic>{
      'grapeId': instance.grapeId,
      'createdAt': instance.createdAt.toIso8601String(),
      'videoUrl': instance.videoUrl,
    };
