// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateModel _$UserCreateModelFromJson(Map<String, dynamic> json) =>
    UserCreateModel(
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      email: json['email'] as String,
      isPrivate: json['isPrivate'] as bool,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      password: json['password'] as String,
      passwordRetry: json['passwordRetry'] as String,
      patronymic: json['patronymic'] as String,
      surname: json['surname'] as String,
    );

Map<String, dynamic> _$UserCreateModelToJson(UserCreateModel instance) =>
    <String, dynamic>{
      'birthDate': instance.birthDate?.toIso8601String(),
      'email': instance.email,
      'isPrivate': instance.isPrivate,
      'name': instance.name,
      'nickname': instance.nickname,
      'password': instance.password,
      'passwordRetry': instance.passwordRetry,
      'patronymic': instance.patronymic,
      'surname': instance.surname,
    };
