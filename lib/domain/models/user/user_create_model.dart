import 'package:json_annotation/json_annotation.dart';

part 'user_create_model.g.dart';

@JsonSerializable()
class UserCreateModel {
  final DateTime? birthDate;
  final String email;
  final bool isPrivate;
  final String name;
  final String nickname;
  final String password;
  final String passwordRetry;
  final String patronymic;
  final String surname;

  UserCreateModel({
    required this.birthDate,
    required this.email,
    required this.isPrivate,
    required this.name,
    required this.nickname,
    required this.password,
    required this.passwordRetry,
    required this.patronymic,
    required this.surname,
  });

  factory UserCreateModel.fromJson(Map<String, dynamic> json) {
    return _$UserCreateModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserCreateModelToJson(this);
  }
}
