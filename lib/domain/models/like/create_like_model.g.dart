// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLikeModel _$CreateLikeModelFromJson(Map<String, dynamic> json) =>
    CreateLikeModel(
      isLike: json['isLike'] as bool?,
      entityId: json['entityId'] as String,
      entityType: $enumDecode(_$LikableEntitiesEnumMap, json['entityType']),
    );

Map<String, dynamic> _$CreateLikeModelToJson(CreateLikeModel instance) =>
    <String, dynamic>{
      'isLike': instance.isLike,
      'entityId': instance.entityId,
      'entityType': _$LikableEntitiesEnumMap[instance.entityType]!,
    };

const _$LikableEntitiesEnumMap = {
  LikableEntities.post: 0,
  LikableEntities.comment: 1,
};
