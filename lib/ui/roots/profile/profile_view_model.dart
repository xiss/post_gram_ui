import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';

class ProfileViewModel extends ChangeNotifier {
  BuildContext context;
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  final AttachmentService _attachmentService = AttachmentService();
  List<SubscriptionModel> slaveSubscriptions = <SubscriptionModel>[];
  List<SubscriptionModel> masterSubscriptions = <SubscriptionModel>[];

  String fullName = "";
  String birthDate = "";
  String eMail = "";
  String folowers = "";
  String subscriptions = "";
  NetworkImage? avatar;

  ProfileViewModel({required this.context}) {
    _asyncInit();
  }

  // UserModel? get user => _user;
  // set user(UserModel? val) {
  //   _user = val;
  //   notifyListeners(); //TODO это нужно вообще?
  // }

  void _asyncInit() async {
    // user = await SharedPreferencesHelper.getStoredUser();
    slaveSubscriptions = await _userService.getSlaveSubscriptions();
    masterSubscriptions = await _userService.getMasterSubscriptions();

    folowers = "Folowers: ${masterSubscriptions.length}";
    subscriptions = "Subscriptions: ${slaveSubscriptions.length}";

    UserModel? userL = await SharedPreferencesHelper.getStoredUser();
    if (userL != null) {
      fullName =
          "${userL.name} ${userL.patronymic} ${userL.surname} (${userL.nickname})";
      birthDate =
          "Birthdate: ${DateFormat('dd.MM.yyyy').format(userL.birthDate.toLocal())}";
      eMail = "Email: ${userL.email}";
      AttachmentModel? avatarL = userL.avatar;
      if (avatarL != null) {
        avatar = await _attachmentService.getAttachment(avatarL.link);
      }
    }
    notifyListeners();
  }

  void logout() async {
    await _authService.logout().then((value) => AppNavigator.toLoader());
  }
}
