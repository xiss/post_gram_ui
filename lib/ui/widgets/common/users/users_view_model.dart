import 'package:flutter/material.dart';

import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/models/subscription/create_subscription_model.dart';
import 'package:post_gram_ui/domain/models/subscription/update_subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_subscriptions_avatar_model.dart';

class UsersViewModel extends ChangeNotifier {
  BuildContext context;
  final UserService _userService = UserService();
  final bool slaveSubs;
  final bool masterSubs;
  bool _disposed = false;

  UsersViewModel(
      {required this.masterSubs,
      required this.slaveSubs,
      required this.context}) {
    _acyncInit();
  }

  List<UserSubscriptionsAvatarModel> _users = [];
  List<UserSubscriptionsAvatarModel> get users => _users;
  set users(List<UserSubscriptionsAvatarModel> users) {
    _users = users;
    notifyListeners();
  }

  Future _acyncInit() async {
    await _userService.syncUsers();
    await _userService.syncSubscriptions();
    users = await _userService.getSubscriptionsWithUsers();
    if (masterSubs) {
      users =
          users.where((element) => element.masterSubscription != null).toList();
    }
  }

  Future subscribe(UserSubscriptionsAvatarModel userDetails) async {
    CreateSubscriptionModel model =
        CreateSubscriptionModel(masterId: userDetails.user.id);
    await _userService.createSubscription(model);
    await _acyncInit();
    notifyListeners();
  }

  Future unsubscribe(UserSubscriptionsAvatarModel userDetails) async {
    //TODO unsubscribe
  }

  Future confirmSubscription(UserSubscriptionsAvatarModel userDetails) async {
    await _updateSubscriptionStatus(userDetails, true);
    await _acyncInit();
    notifyListeners();
  }

  Future recallConfirmationSubscription(
      UserSubscriptionsAvatarModel userDetails) async {
    await _updateSubscriptionStatus(userDetails, false);
    await _acyncInit();
    notifyListeners();
  }

  Future _updateSubscriptionStatus(
      UserSubscriptionsAvatarModel userDetails, bool newStatus) async {
    String? masterSubscriptionId = userDetails.masterSubscription?.id;
    if (masterSubscriptionId != null) {
      UpdateSubscriptionModel model =
          UpdateSubscriptionModel(id: masterSubscriptionId, status: newStatus);
      await _userService.updateSubscription(model);
      await _userService.syncSubscriptions();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
