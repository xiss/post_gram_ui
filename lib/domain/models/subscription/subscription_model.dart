import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel {
  String id;
  String slaveId;
  String masterId;
  bool status;
  DateTime created;
  DateTime? edited;

  SubscriptionModel({
    required this.id,
    required this.slaveId,
    required this.masterId,
    required this.status,
    required this.created,
    required this.edited,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionModelFromJson(json);
  }
  factory SubscriptionModel.fromEntity(Subscription entity) {
    return SubscriptionModel.fromJson(entity.toJson());
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionModelToJson(this);
  }
}
