// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Like _$LikeFromJson(Map<String, dynamic> json) => Like(
      id: json['id'] as String,
      isLike: json['isLike'] as bool?,
      entityId: json['entityId'] as String,
      authorId: json['authorId'] as String,
      created: DateTime.parse(json['created'] as String),
      entityType: $enumDecode(_$LikableEntitiesEnumMap, json['entityType']),
    );

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
      'id': instance.id,
      'isLike': instance.isLike,
      'entityId': instance.entityId,
      'authorId': instance.authorId,
      'created': instance.created.toIso8601String(),
      'entityType': _$LikableEntitiesEnumMap[instance.entityType]!,
    };

const _$LikableEntitiesEnumMap = {
  LikableEntities.post: 0,
  LikableEntities.comment: 1,
};
