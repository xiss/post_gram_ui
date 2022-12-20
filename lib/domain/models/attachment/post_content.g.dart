// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostContent _$PostContentFromJson(Map<String, dynamic> json) => PostContent(
      id: json['id'] as String,
      name: json['name'] as String,
      mimeType: json['mimeType'] as String,
      link: json['link'] as String,
      postId: json['postId'] as String,
    );

Map<String, dynamic> _$PostContentToJson(PostContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mimeType': instance.mimeType,
      'link': instance.link,
      'postId': instance.postId,
    };
