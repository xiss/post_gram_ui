// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostModel _$CreatePostModelFromJson(Map<String, dynamic> json) =>
    CreatePostModel(
      header: json['header'] as String,
      body: json['body'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => MetadataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreatePostModelToJson(CreatePostModel instance) =>
    <String, dynamic>{
      'header': instance.header,
      'body': instance.body,
      'attachments': instance.attachments,
    };
