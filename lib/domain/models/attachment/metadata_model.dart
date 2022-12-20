import 'package:json_annotation/json_annotation.dart';

part 'metadata_model.g.dart';

@JsonSerializable()
class MetadataModel {
  String tempId;
  String name;
  String mimeType;
  int size;

  MetadataModel({
    required this.tempId,
    required this.name,
    required this.mimeType,
    required this.size,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return _$MetadataModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataModelToJson(this);
  }
}
