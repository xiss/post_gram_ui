import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/helpers/converter.dart';

part 'post.g.dart';

@JsonSerializable()
class Post implements DbModelBase {
  String? authorId; //TODO сделать поле имутабельным
  @override
  final String id;
  final DateTime created;
  final DateTime? edited;
  final String header;
  final String body;
  final int likeCount;
  final int dislikeCount;
  final int commentCount;
  final bool? isLikedByUser;
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
    this.isLikedByUser,
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
      isLikedByUser: Converter.intToBool(map['isLikedByUser'] as int?),
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return _$PostFromJson(json);
  }

  factory Post.fromModel(PostModel model) {
    Post result = _$PostFromJson(model.toJson());
    result.authorId = model.author.id;
    return result;
  }

  Map<String, dynamic> toJson() {
    return _$PostToJson(this);
  }
}
