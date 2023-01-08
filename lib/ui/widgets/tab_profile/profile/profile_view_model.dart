import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/domain/models/user/user_subscriptions_avatar_model.dart';
import 'package:post_gram_ui/ui/navigation/app_navigator.dart';
import 'package:post_gram_ui/ui/widgets/common/camera_widget.dart';

class ProfileViewModel extends ChangeNotifier {
  BuildContext context;
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  final AttachmentService _attachmentService = AttachmentService();
  List<UserSubscriptionsAvatarModel> subscriptionList = [];

  String fullName = "";
  String birthDate = "";
  String eMail = "";
  String followers = "";
  String subscriptions = "";

  NetworkImage? _avatar;
  NetworkImage? get avatar => _avatar;
  set avatar(NetworkImage? avatar) {
    _avatar = avatar;
    notifyListeners();
  }

  Exception? _exeption;
  Exception? get exeption => _exeption;
  set exeption(Exception? exeption) {
    _exeption = exeption;
    notifyListeners();
  }

  String? _newAvatarFilePath;
  String? get newAvatarFilePath => _newAvatarFilePath;
  set newAvatarFilePath(String? value) {
    _newAvatarFilePath = value;
    notifyListeners();
  }

  ProfileViewModel({required this.context}) {
    _asyncInit();
  }

  Future changePhoto() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (newContext) => CameraWidget(
          title: "Take a new avatar",
          onFile: (file) {
            newAvatarFilePath = file.path;
            Navigator.of(newContext).pop();
          },
        ),
      ),
    );
    if (newAvatarFilePath != null) {
      try {
        MetadataModel model =
            await _attachmentService.uploadFile(File(newAvatarFilePath!));
        await _attachmentService.deleteCurrentUserAvatar();
        await _attachmentService.addAvatarToUser(model);
        if (avatar == null) {
          await _userService.syncCurrentUser();
          await _asyncInit();
        }
        await avatar?.evict();
      } on Exception catch (e) {
        exeption = e;
      }
      notifyListeners();
    }
  }

  Future _asyncInit() async {
    UserModel? userL;
    try {
      await _userService.syncSubscriptions();

      subscriptionList = await _userService.getSubscriptionsWithUsers();
      userL = await _userService.getCurrentUser();
    } on Exception catch (e) {
      exeption = e;
    }

    followers =
        "Followers: ${subscriptionList.where((element) => element.masterSubscription != null).length}";
    subscriptions =
        "Subscriptions: ${subscriptionList.where((element) => element.slaveSubscription != null).length}";
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
