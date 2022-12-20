// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      authorId: json['authorId'] as String?,
      id: json['id'] as String,
      created: DateTime.parse(json['created'] as String),
      edited: json['edited'] == null
          ? null
          : DateTime.parse(json['edited'] as String),
      header: json['header'] as String,
      body: json['body'] as String,
      likeCount: json['likeCount'] as int,
      dislikeCount: json['dislikeCount'] as int,
      commentCount: json['commentCount'] as int,
      isLikedByUser: json['isLikedByUser'] as bool?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'authorId': instance.authorId,
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'edited': instance.edited?.toIso8601String(),
      'header': instance.header,
      'body': instance.body,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'commentCount': instance.commentCount,
      'isLikedByUser': instance.isLikedByUser,
    };
