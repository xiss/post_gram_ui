import 'package:json_annotation/json_annotation.dart';

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

  Map<String, dynamic> toJson() {
    return _$AttachmentModelToJson(this);
  }
}
