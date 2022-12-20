import 'package:json_annotation/json_annotation.dart';

import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';

part 'avatar.g.dart';

@JsonSerializable()
class Avatar implements DbModelBase {
  @override
  final String id;
  final String name;
  final String mimeType;
  final String link;
  final String userId;

  Avatar({
    required this.id,
    required this.name,
    required this.mimeType,
    required this.link,
    required this.userId,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return _$AvatarFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AvatarToJson(this);
  }

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Avatar.fromMap(Map<String, dynamic> map) {
    return _$AvatarFromJson(map);
  }

  factory Avatar.fromModel(AttachmentModel model, String userId) {
    return Avatar(
        id: model.id,
        name: model.name,
        mimeType: model.mimeType,
        link: model.link,
        userId: userId);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Avatar && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
