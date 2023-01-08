import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/helpers/converter.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements DbModelBase {
  String? avatarId;
  @override
  final String id;
  final String name;
  final String surname;
  final String patronymic;
  final String email;
  final String nickname;
  final DateTime birthDate;
  final bool isPrivate;

  User(
      {this.avatarId,
      required this.id,
      required this.name,
      required this.surname,
      required this.patronymic,
      required this.email,
      required this.nickname,
      required this.birthDate,
      required this.isPrivate});

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      avatarId: map['avatarId'] as String?,
      id: map['id'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      patronymic: map['patronymic'] as String,
      email: map['email'] as String,
      nickname: map['nickname'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      isPrivate: Converter.intToBool(map['isPrivate'] as int),
    );
  }

  factory User.fromModel(UserModel model) {
    User result = _$UserFromJson(model.toJson());
    if (model.avatar != null) {
      result.avatarId = model.avatar?.id;
    } else {
      result.avatarId = null;
    }
    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
