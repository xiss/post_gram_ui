// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommentModel _$CreateCommentModelFromJson(Map<String, dynamic> json) =>
    CreateCommentModel(
      body: json['body'] as String,
      postId: json['postId'] as String,
      quotedCommentId: json['quotedCommentId'] as String?,
      quotedText: json['quotedText'] as String?,
    );

Map<String, dynamic> _$CreateCommentModelToJson(CreateCommentModel instance) =>
    <String, dynamic>{
      'body': instance.body,
      'postId': instance.postId,
      'quotedCommentId': instance.quotedCommentId,
      'quotedText': instance.quotedText,
    };
