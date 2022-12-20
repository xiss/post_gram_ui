import 'package:json_annotation/json_annotation.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription implements DbModelBase {
  @override
  String id;
  String slaveId;
  String masterId;
  bool status;
  DateTime created;
  DateTime? edited;

  Subscription({
    required this.id,
    required this.slaveId,
    required this.masterId,
    required this.status,
    required this.created,
    required this.edited,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionToJson(this);
  }

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return _$SubscriptionFromJson(map);
  }
}
