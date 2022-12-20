// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      avatarId: json['avatarId'] as String?,
      id: json['id'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      patronymic: json['patronymic'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'avatarId': instance.avatarId,
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'patronymic': instance.patronymic,
      'email': instance.email,
      'nickname': instance.nickname,
      'birthDate': instance.birthDate.toIso8601String(),
    };
