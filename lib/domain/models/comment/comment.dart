import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment implements DbModelBase {
  @override
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

  Comment({
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

  @override
  Map<String, dynamic> toMap() {
    return _$CommentToJson(this);
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return _$CommentFromJson(map);
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return _$CommentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommentToJson(this);
  }
}
