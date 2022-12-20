import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  String id;
  UserModel author;
  String postId;
  String created;
  String edited;
  String body;
  int likeCount;
  int dislikeCount;
  String quotedCommentId;
  String quotedText;

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
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return _$CommentModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommentModelToJson(this);
  }
}
