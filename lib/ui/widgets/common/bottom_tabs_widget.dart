import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/enums/tab_item.dart';
import 'package:post_gram_ui/ui/navigation/tab_enums.dart';

class BottomTabsWidget extends StatelessWidget {
  final TabItemEnum currentTab;
  final ValueChanged<TabItemEnum> onSelectTab;
  const BottomTabsWidget(
      {super.key, required this.currentTab, required this.onSelectTab});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: TabItemEnum.values.map((e) => _getItem(e)).toList(),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      currentIndex: TabItemEnum.values.indexOf(currentTab),
      onTap: (value) {
        FocusScope.of(context).unfocus();
        onSelectTab(TabItemEnum.values[value]);
      },
    );
  }

  BottomNavigationBarItem _getItem(TabItemEnum tabItem) {
    IconData? icon = TabEnums.tabIcon[tabItem];

    return BottomNavigationBarItem(
      label: tabItem.name,
      icon: icon != null ? Icon(icon) : Text(tabItem.name),
    );
  }
}
