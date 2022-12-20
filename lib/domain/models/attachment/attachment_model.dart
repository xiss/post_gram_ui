import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/attachment/avatar.dart';
import 'package:post_gram_ui/domain/models/attachment/post_content.dart';

part 'attachment_model.g.dart';

@JsonSerializable()
class AttachmentModel {
  final String id;
  final String name;
  final String mimeType;
  final String link;

  AttachmentModel({
    required this.id,
    required this.name,
    required this.mimeType,
    required this.link,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return _$AttachmentModelFromJson(json);
  }

  factory AttachmentModel.fromPostContent(PostContent postContent) {
    return AttachmentModel.fromJson(postContent.toJson());
  }

  factory AttachmentModel.fromAvatar(Avatar avatar) {
    return AttachmentModel.fromJson(avatar.toJson());
  }

  Map<String, dynamic> toJson() {
    return _$AttachmentModelToJson(this);
  }
}
