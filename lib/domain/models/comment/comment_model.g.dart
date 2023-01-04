// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as String,
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
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
      likeByUser: json['likeByUser'] == null
          ? null
          : LikeModel.fromJson(json['likeByUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'postId': instance.postId,
      'created': instance.created.toIso8601String(),
      'edited': instance.edited?.toIso8601String(),
      'body': instance.body,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'quotedCommentId': instance.quotedCommentId,
      'quotedText': instance.quotedText,
      'likeByUser': instance.likeByUser,
    };
