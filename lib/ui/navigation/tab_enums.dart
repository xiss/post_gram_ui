import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/enums/tab_item.dart';
import 'package:post_gram_ui/ui/widgets/roots/create_post/create_post_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/home/home_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_profile/profile/profile_widget.dart';

class TabEnums {
  static const TabItemEnum defaultTab = TabItemEnum.home;

  static Map<TabItemEnum, IconData> tabIcon = {
    TabItemEnum.createPost: Icons.add,
    TabItemEnum.home: Icons.home,
    TabItemEnum.profile: Icons.person,
    TabItemEnum.search: Icons.search
  };

  static Map<TabItemEnum, Widget> tabRoots = {
    TabItemEnum.createPost: CreatePostWidget.create(),
    TabItemEnum.home: HomeWidget.create(),
    TabItemEnum.profile: ProfileWidget.create(),
  };
}
