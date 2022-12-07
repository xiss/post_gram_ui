import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';

class MainViewModel extends ChangeNotifier {
  BuildContext context;
  String name = "";
  NetworkImage? avater;
  final AttachmentService _attachmentService = AttachmentService();
  MainViewModel({required this.context}) {
    _asyncInit();
  }

  void _asyncInit() async {
    UserModel? user = await SharedPreferencesHelper.getStoredUser();
    if (user != null) {
      name = "${user.name} (${user.nickname})";

      AttachmentModel? avatarL = user.avatar;
      if (avatarL != null) {
        avater = await _attachmentService.getAttachment(avatarL.link);
      }
    }
    notifyListeners();
  }

  void profile() {
    AppNavigator.toProfile();
  }
}
