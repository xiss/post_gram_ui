import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/attachment/avatar.dart';
import 'package:post_gram_ui/domain/models/user/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  AttachmentModel? avatar;
  final String id;
  final String name;
  final String surname;
  final String patronymic;
  final String email;
  final String nickname;
  final DateTime birthDate;
  final bool isPrivate;

  UserModel(
      {this.avatar,
      required this.id,
      required this.name,
      required this.surname,
      required this.patronymic,
      required this.email,
      required this.nickname,
      required this.birthDate,
      required this.isPrivate});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  factory UserModel.fromEntity(User entity, Avatar? avatar) {
    UserModel result = _$UserModelFromJson(entity.toMap());
    result.avatar = avatar != null ? AttachmentModel.fromAvatar(avatar) : null;
    return result;
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
