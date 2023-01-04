import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/enums/tab_item.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/ui/navigation/tab_enums.dart';

class AppViewModel extends ChangeNotifier {
  BuildContext context;
  final AttachmentService _attachmentService = AttachmentService();
  final UserService _userService = UserService();

  AppViewModel({required this.context}) {
    _asyncInit();
  }

  final navigationKeys = {
    TabItemEnum.createPost: GlobalKey<NavigatorState>(),
    TabItemEnum.home: GlobalKey<NavigatorState>(),
    TabItemEnum.profile: GlobalKey<NavigatorState>(),
    TabItemEnum.search: GlobalKey<NavigatorState>(),
  };

  //TabItemEnum? _beforeTab;
  TabItemEnum _currentTab = TabEnums.defaultTab;
  get currentTab => _currentTab;

  void selectTab(TabItemEnum item) {
    if (item == _currentTab) {
      navigationKeys[item]!
          .currentState!
          .popUntil((route) => route.isFirst); //TODO
    } else {
      // _beforeTab = _currentTab;
      _currentTab = item;
      notifyListeners();
    }
  }

  String _name = "";
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  NetworkImage? _avatar;
  NetworkImage? get avatar => _avatar;
  set avatar(NetworkImage? value) {
    _avatar = value;
    notifyListeners();
  }

  void _asyncInit() async {
    UserModel? user = await _userService.getCurrentUser();
    if (user != null) {
      name = "${user.name} (${user.nickname})";

      AttachmentModel? avatarL = user.avatar;
      if (avatarL != null) {
        avatar = await _attachmentService.getAttachment(avatarL.link);
      }
    }
  }
}
