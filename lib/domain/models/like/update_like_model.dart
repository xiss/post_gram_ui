import 'package:json_annotation/json_annotation.dart';

part 'update_like_model.g.dart';

@JsonSerializable()
class UpdateLikeModel {
  final String id;
  final bool? isLike;

  UpdateLikeModel({
    required this.id,
    required this.isLike,
  });
  factory UpdateLikeModel.fromJson(Map<String, dynamic> json) {
    return _$UpdateLikeModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateLikeModelToJson(this);
  }
}
