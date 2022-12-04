// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) =>
    SubscriptionModel(
      id: json['id'] as String,
      slaveId: json['slaveId'] as String,
      masterId: json['masterId'] as String,
      status: json['status'] as bool,
      created: DateTime.parse(json['created'] as String),
      edited: json['edited'] == null
          ? null
          : DateTime.parse(json['edited'] as String),
    );

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slaveId': instance.slaveId,
      'masterId': instance.masterId,
      'status': instance.status,
      'created': instance.created.toIso8601String(),
      'edited': instance.edited?.toIso8601String(),
    };
