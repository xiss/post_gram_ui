import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';

class UserSubscriptionsAvatarModel {
  final UserModel user;
  final Future<NetworkImage> avatar;
  final SubscriptionModel? slaveSubscription;
  final SubscriptionModel? masterSubscription;
  UserSubscriptionsAvatarModel({
    required this.user,
    required this.avatar,
    required this.slaveSubscription,
    required this.masterSubscription,
  });
}
