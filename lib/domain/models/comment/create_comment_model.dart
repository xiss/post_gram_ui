import 'package:json_annotation/json_annotation.dart';

part 'create_comment_model.g.dart';

@JsonSerializable()
class CreateCommentModel {
  final String body;
  final String postId;
  final String? quotedCommentId;
  final String? quotedText;

  CreateCommentModel({
    required this.body,
    required this.postId,
    required this.quotedCommentId,
    required this.quotedText,
  });

  factory CreateCommentModel.fromJson(Map<String, dynamic> json) {
    return _$CreateCommentModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateCommentModelToJson(this);
  }
}
