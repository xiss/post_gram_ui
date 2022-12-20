// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
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
      content: (json['content'] as List<dynamic>)
          .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLikedByUser: json['isLikedByUser'] as bool?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'author': instance.author,
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'edited': instance.edited?.toIso8601String(),
      'header': instance.header,
      'body': instance.body,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'commentCount': instance.commentCount,
      'isLikedByUser': instance.isLikedByUser,
      'content': instance.content,
    };
