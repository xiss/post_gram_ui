import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';

part 'post.g.dart';

@JsonSerializable()
class Post implements DbModelBase {
  String? authorId;
  @override
  final String id;
  final DateTime created;
  final DateTime? edited;
  final String header;
  final String body;
  final int likeCount;
  final int dislikeCount;
  final int commentCount;
  String? likeByUserId;

  Post({
    this.authorId,
    required this.id,
    required this.created,
    required this.edited,
    required this.header,
    required this.body,
    required this.likeCount,
    required this.dislikeCount,
    required this.commentCount,
    this.likeByUserId,
  });

  @override
  Map<String, dynamic> toMap() {
    return _$PostToJson(this);
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      authorId: map['authorId'] as String?,
      id: map['id'] as String,
      created: DateTime.parse(map['created'] as String),
      edited: map['edited'] == null
          ? null
          : DateTime.parse(map['edited'] as String),
      header: map['header'] as String,
      body: map['body'] as String,
      likeCount: map['likeCount'] as int,
      dislikeCount: map['dislikeCount'] as int,
      commentCount: map['commentCount'] as int,
      likeByUserId: map['likeByUserId'] as String?,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return _$PostFromJson(json);
  }

  factory Post.fromModel(PostModel model) {
    Post result = _$PostFromJson(model.toJson());
    result.authorId = model.author.id;
    result.likeByUserId = model.likeByUser?.id;
    return result;
  }

  Map<String, dynamic> toJson() {
    return _$PostToJson(this);
  }
}
