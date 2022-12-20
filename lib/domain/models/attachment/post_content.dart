import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';

part 'post_content.g.dart';

@JsonSerializable()
class PostContent implements DbModelBase {
  @override
  final String id;
  final String name;
  final String mimeType;
  final String link;
  final String postId;

  PostContent({
    required this.id,
    required this.name,
    required this.mimeType,
    required this.link,
    required this.postId,
  });

  factory PostContent.fromJson(Map<String, dynamic> json) {
    return _$PostContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PostContentToJson(this);
  }

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory PostContent.fromMap(Map<String, dynamic> map) {
    return _$PostContentFromJson(map);
  }

  factory PostContent.fromModel(AttachmentModel model, String postId) {
    return PostContent(
        id: model.id,
        name: model.name,
        mimeType: model.mimeType,
        link: model.link,
        postId: postId);
  }
}
