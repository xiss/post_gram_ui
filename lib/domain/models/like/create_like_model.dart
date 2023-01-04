import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/enums/likable_entities.dart';

part 'create_like_model.g.dart';

@JsonSerializable()
class CreateLikeModel {
  final bool? isLike;
  final String entityId;
  final LikableEntities entityType;

  CreateLikeModel({
    required this.isLike,
    required this.entityId,
    required this.entityType,
  });

  factory CreateLikeModel.fromJson(Map<String, dynamic> json) {
    return _$CreateLikeModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateLikeModelToJson(this);
  }
}
