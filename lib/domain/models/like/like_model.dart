import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/enums/likable_entities.dart';
import 'package:post_gram_ui/domain/models/like/like.dart';
part 'like_model.g.dart';

@JsonSerializable()
class LikeModel {
  String id;
  bool? isLike;
  String entityId;
  String authorId;
  DateTime created;
  LikableEntities entityType;

  LikeModel({
    required this.id,
    required this.isLike,
    required this.entityId,
    required this.authorId,
    required this.created,
    required this.entityType,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return _$LikeModelFromJson(json);
  }
  factory LikeModel.fromEntity(Like entity) {
    return LikeModel.fromJson(entity.toJson());
  }

  Map<String, dynamic> toJson() {
    return _$LikeModelToJson(this);
  }
}
