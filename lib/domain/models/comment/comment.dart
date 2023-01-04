import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment implements DbModelBase {
  @override
  final String id;
  String? authorId;
  final String postId;
  final DateTime created;
  final DateTime? edited;
  final String body;
  final int likeCount;
  final int dislikeCount;
  final String? quotedCommentId;
  final String? quotedText;
  String? likeByUserId;

  Comment({
    required this.id,
    required this.authorId,
    required this.postId,
    required this.created,
    required this.edited,
    required this.body,
    required this.likeCount,
    required this.dislikeCount,
    required this.quotedCommentId,
    required this.quotedText,
    required this.likeByUserId,
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

  factory Comment.fromModel(CommentModel model) {
    Comment result = _$CommentFromJson(model.toJson());
    result.authorId = model.author.id;
    result.likeByUserId = model.likeByUser?.id;
    return result;
  }

  Map<String, dynamic> toJson() {
    return _$CommentToJson(this);
  }
}
