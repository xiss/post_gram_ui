import 'package:json_annotation/json_annotation.dart';

part 'update_subscription_model.g.dart';

@JsonSerializable()
class UpdateSubscriptionModel {
  final String id;
  final bool status;
  UpdateSubscriptionModel({
    required this.id,
    required this.status,
  });

  factory UpdateSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return _$UpdateSubscriptionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateSubscriptionModelToJson(this);
  }
}
