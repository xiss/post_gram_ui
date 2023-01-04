import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/enums/likable_entities.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';
import 'package:post_gram_ui/domain/models/like/like_model.dart';
import 'package:post_gram_ui/helpers/converter.dart';
part 'like.g.dart';

@JsonSerializable()
class Like implements DbModelBase {
  @override
  String id;
  bool? isLike;
  String entityId;
  String authorId;
  DateTime created;
  LikableEntities entityType;

  Like({
    required this.id,
    required this.isLike,
    required this.entityId,
    required this.authorId,
    required this.created,
    required this.entityType,
  });

  @override
  Map<String, dynamic> toMap() {
    return _$LikeToJson(this);
  }

  factory Like.fromJson(Map<String, dynamic> json) {
    return _$LikeFromJson(json);
  }

  factory Like.fromModel(LikeModel model) {
    Like result = _$LikeFromJson(model.toJson());
    return result;
  }

  Map<String, dynamic> toJson() {
    return _$LikeToJson(this);
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
        id: map['id'] as String,
        isLike: Converter.intToBool(map['isLike'] as int?),
        entityId: map['entityId'] as String,
        authorId: map['authorId'] as String,
        created: DateTime.parse(map['created'] as String),
        entityType: LikableEntities.values[map['entityType'] as int]);
  }
}
