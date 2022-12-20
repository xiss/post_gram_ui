import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';
import 'package:post_gram_ui/ui/common/camera_widget.dart';

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
  String followers = "";
  String subscriptions = "";
  NetworkImage? avatar;

  String? _error;
  String? get error => _error;
  set error(String? value) {
    _error = value;
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
        await avatar?.evict();
        notifyListeners();
      } catch (e) {
        //TODO обработка ошибок
        error = "inner Exception";
      }
    }
  }

  void _asyncInit() async {
    UserModel? userL;
    try {
      slaveSubscriptions = await _userService.getSlaveSubscriptions();
      masterSubscriptions = await _userService.getMasterSubscriptions();
      userL = await SharedPreferencesHelper.getStoredUser();
    } on InnerPostGramException catch (e) {
      error = e.message;
    }

    followers = "Followers: ${masterSubscriptions.length}";
    subscriptions = "Subscriptions: ${slaveSubscriptions.length}";
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
    //TODO Наверное стоит создать свойства в модели и обновлять там
    notifyListeners();
  }

  void logout() async {
    await _authService.logout().then((value) => AppNavigator.toLoader());
  }
}
