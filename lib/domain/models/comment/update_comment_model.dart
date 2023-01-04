import 'package:json_annotation/json_annotation.dart';

part 'update_comment_model.g.dart';

@JsonSerializable()
class UpdateCommentModel {
  final String id;
  final String newBody;

  UpdateCommentModel({
    required this.id,
    required this.newBody,
  });

  factory UpdateCommentModel.fromJson(Map<String, dynamic> json) {
    return _$UpdateCommentModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateCommentModelToJson(this);
  }
}
