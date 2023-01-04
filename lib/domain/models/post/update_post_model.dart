import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';

part 'update_post_model.g.dart';

@JsonSerializable()
class UpdatePostModel {
  final String id;
  final String updatedHeader;
  final String updatedBody;
  final List<MetadataModel> newContent;
  final List<AttachmentModel> contentToDelete;

  UpdatePostModel({
    required this.id,
    required this.updatedHeader,
    required this.updatedBody,
    required this.newContent,
    required this.contentToDelete,
  });

  factory UpdatePostModel.fromJson(Map<String, dynamic> json) {
    return _$UpdatePostModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdatePostModelToJson(this);
  }
}
