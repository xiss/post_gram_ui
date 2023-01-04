import 'package:json_annotation/json_annotation.dart';

enum LikableEntities {
  @JsonValue(0)
  post,
  @JsonValue(1)
  comment,
}
