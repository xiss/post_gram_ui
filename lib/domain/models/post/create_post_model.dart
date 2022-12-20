import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';

part 'create_post_model.g.dart';

@JsonSerializable()
class CreatePostModel {
  String header;
  String body;
  List<MetadataModel> attachments;

  CreatePostModel({
    required this.header,
    required this.body,
    required this.attachments,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) {
    return _$CreatePostModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreatePostModelToJson(this);
  }
}
