import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/enums/tab_item.dart';
import 'package:post_gram_ui/ui/navigation/tab_enums.dart';

class AppViewModel extends ChangeNotifier {
  BuildContext context;

  AppViewModel({required this.context}) {
    _asyncInit();
  }

  final Map<TabItemEnum, GlobalKey<NavigatorState>> navigationKeys = {
    TabItemEnum.createPost: GlobalKey<NavigatorState>(),
    TabItemEnum.home: GlobalKey<NavigatorState>(),
    TabItemEnum.profile: GlobalKey<NavigatorState>(),
    TabItemEnum.users: GlobalKey<NavigatorState>(),
  };

  TabItemEnum _currentTab = TabEnums.defaultTab;
  get currentTab => _currentTab;

  void selectTab(TabItemEnum item) {
    if (item == _currentTab) {
      navigationKeys[item]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      _currentTab = item;
      notifyListeners();
    }
  }

  Future _asyncInit() async {}
}
