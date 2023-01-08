import 'package:json_annotation/json_annotation.dart';

part 'create_subscription_model.g.dart';

@JsonSerializable()
class CreateSubscriptionModel {
  final String masterId;
  CreateSubscriptionModel({
    required this.masterId,
  });

  factory CreateSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return _$CreateSubscriptionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateSubscriptionModelToJson(this);
  }
}
