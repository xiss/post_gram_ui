import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/attachment/post_content.dart';
import 'package:post_gram_ui/domain/models/like/like.dart';
import 'package:post_gram_ui/domain/models/like/like_model.dart';
import 'package:post_gram_ui/domain/models/post/post.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final UserModel author;
  final String id;
  final DateTime created;
  final DateTime? edited;
  final String header;
  final String body;
  final int likeCount;
  final int dislikeCount;
  final int commentCount;
  final LikeModel? likeByUser;
  List<AttachmentModel> content;

  PostModel({
    required this.author,
    required this.id,
    required this.created,
    this.edited,
    required this.header,
    required this.body,
    required this.likeCount,
    required this.dislikeCount,
    required this.commentCount,
    required this.content,
    required this.likeByUser,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return _$PostModelFromJson(json);
  }

  factory PostModel.fromEntity(
    Post entity,
    UserModel author,
    List<PostContent> content,
    Like? likeByUser,
  ) {
    return PostModel(
        author: author,
        id: entity.id,
        created: entity.created,
        header: entity.header,
        body: entity.body,
        likeCount: entity.likeCount,
        dislikeCount: entity.dislikeCount,
        commentCount: entity.commentCount,
        likeByUser:
            likeByUser == null ? null : LikeModel.fromEntity(likeByUser),
        edited: entity.edited,
        content:
            content.map((e) => AttachmentModel.fromPostContent(e)).toList());
  }

  Map<String, dynamic> toJson() {
    return _$PostModelToJson(this);
  }
}
