import 'package:flutter/material.dart';

import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/models/subscription/create_subscription_model.dart';
import 'package:post_gram_ui/domain/models/subscription/update_subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_subscriptions_avatar_model.dart';
import 'package:post_gram_ui/ui/widgets/roots/app/app_view_model.dart';
import 'package:provider/provider.dart';

class UsersViewModel extends ChangeNotifier {
  BuildContext context;
  final UserService _userService = UserService();
  final bool slaveSubs;
  final bool masterSubs;
  bool _disposed = false;
  AppViewModel? _appViewModel;

  UsersViewModel(
      {required this.masterSubs,
      required this.slaveSubs,
      required this.context}) {
    _acyncInit();
    _appViewModel = context.read<AppViewModel>();
  }

  List<UserSubscriptionsAvatarModel> _users = [];
  List<UserSubscriptionsAvatarModel> get users => _users;
  set users(List<UserSubscriptionsAvatarModel> users) {
    _users = users;
    notifyListeners();
  }

  Exception? _exeption;
  Exception? get exeption => _exeption;
  set exeption(Exception? exeption) {
    _exeption = exeption;
    notifyListeners();
  }

  Future _acyncInit() async {
    try {
      await _userService.syncUsers();
      await _userService.syncSubscriptions();
      users = await _userService.getSubscriptionsWithUsers();
    } on Exception catch (e) {
      exeption = e;
    }

    if (masterSubs) {
      users =
          users.where((element) => element.masterSubscription != null).toList();
    }
  }

  Future subscribe(UserSubscriptionsAvatarModel userDetails) async {
    CreateSubscriptionModel model =
        CreateSubscriptionModel(masterId: userDetails.user.id);
    try {
      await _userService.createSubscription(model);
    } on Exception catch (e) {
      exeption = e;
    }

    await _acyncInit();
    _appViewModel?.notifyListeners();
  }

  Future unsubscribe(UserSubscriptionsAvatarModel userDetails) async {
    //TODO unsubscribe
  }

  Future confirmSubscription(UserSubscriptionsAvatarModel userDetails) async {
    try {
      await _updateSubscriptionStatus(userDetails, true);
    } on Exception catch (e) {
      exeption = e;
    }

    await _acyncInit();
  }

  Future recallConfirmationSubscription(
      UserSubscriptionsAvatarModel userDetails) async {
    try {
      await _updateSubscriptionStatus(userDetails, false);
    } on Exception catch (e) {
      exeption = e;
    }

    await _acyncInit();
  }

  Future _updateSubscriptionStatus(
      UserSubscriptionsAvatarModel userDetails, bool newStatus) async {
    String? masterSubscriptionId = userDetails.masterSubscription?.id;
    if (masterSubscriptionId != null) {
      UpdateSubscriptionModel model =
          UpdateSubscriptionModel(id: masterSubscriptionId, status: newStatus);

      try {
        await _userService.updateSubscription(model);
        await _userService.syncSubscriptions();
      } on Exception catch (e) {
        exeption = e;
      }
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
