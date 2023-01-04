// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePostModel _$UpdatePostModelFromJson(Map<String, dynamic> json) =>
    UpdatePostModel(
      id: json['id'] as String,
      updatedHeader: json['updatedHeader'] as String,
      updatedBody: json['updatedBody'] as String,
      newContent: (json['newContent'] as List<dynamic>)
          .map((e) => MetadataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      contentToDelete: (json['contentToDelete'] as List<dynamic>)
          .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdatePostModelToJson(UpdatePostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedHeader': instance.updatedHeader,
      'updatedBody': instance.updatedBody,
      'newContent': instance.newContent,
      'contentToDelete': instance.contentToDelete,
    };
