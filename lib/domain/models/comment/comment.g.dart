// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      postId: json['postId'] as String,
      created: json['created'] as String,
      edited: json['edited'] as String,
      body: json['body'] as String,
      likeCount: json['likeCount'] as int,
      dislikeCount: json['dislikeCount'] as int,
      quotedCommentId: json['quotedCommentId'] as String,
      quotedText: json['quotedText'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'postId': instance.postId,
      'created': instance.created,
      'edited': instance.edited,
      'body': instance.body,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'quotedCommentId': instance.quotedCommentId,
      'quotedText': instance.quotedText,
    };
