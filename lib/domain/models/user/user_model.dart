import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final AttachmentModel? avatar;
  final String id;
  final String name;
  final String surname;
  final String patronymic;
  final String email;
  final String nickname;
  final DateTime birthDate;

  UserModel({
    this.avatar,
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.email,
    required this.nickname,
    required this.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }
}
