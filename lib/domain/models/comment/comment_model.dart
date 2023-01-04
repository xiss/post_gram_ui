import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/comment/comment.dart';
import 'package:post_gram_ui/domain/models/like/like.dart';
import 'package:post_gram_ui/domain/models/like/like_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  final String id;
  final UserModel author;
  final String postId;
  final DateTime created;
  final DateTime? edited;
  final String body;
  final int likeCount;
  final int dislikeCount;
  final String? quotedCommentId;
  final String? quotedText;
  final LikeModel? likeByUser;

  CommentModel({
    required this.id,
    required this.author,
    required this.postId,
    required this.created,
    required this.edited,
    required this.body,
    required this.likeCount,
    required this.dislikeCount,
    required this.quotedCommentId,
    required this.quotedText,
    required this.likeByUser,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return _$CommentModelFromJson(json);
  }

  factory CommentModel.fromEntity(
    Comment entity,
    UserModel author,
    Like? likeByUser,
  ) {
    return CommentModel(
      id: entity.id,
      author: author,
      postId: entity.postId,
      created: entity.created,
      edited: entity.edited,
      body: entity.body,
      likeCount: entity.likeCount,
      dislikeCount: entity.dislikeCount,
      quotedCommentId: entity.quotedCommentId,
      quotedText: entity.quotedText,
      likeByUser: likeByUser == null ? null : LikeModel.fromEntity(likeByUser),
    );
  }

  Map<String, dynamic> toJson() {
    return _$CommentModelToJson(this);
  }
}
