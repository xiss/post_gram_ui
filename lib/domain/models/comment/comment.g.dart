// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      authorId: json['authorId'] as String?,
      postId: json['postId'] as String,
      created: DateTime.parse(json['created'] as String),
      edited: json['edited'] == null
          ? null
          : DateTime.parse(json['edited'] as String),
      body: json['body'] as String,
      likeCount: json['likeCount'] as int,
      dislikeCount: json['dislikeCount'] as int,
      quotedCommentId: json['quotedCommentId'] as String?,
      quotedText: json['quotedText'] as String?,
      likeByUserId: json['likeByUserId'] as String?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'postId': instance.postId,
      'created': instance.created.toIso8601String(),
      'edited': instance.edited?.toIso8601String(),
      'body': instance.body,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'quotedCommentId': instance.quotedCommentId,
      'quotedText': instance.quotedText,
      'likeByUserId': instance.likeByUserId,
    };
