import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/enums/tab_item.dart';
import 'package:post_gram_ui/ui/navigation/tab_enums.dart';
import 'package:post_gram_ui/ui/navigation/tab_navigator_routes.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/create_comment/create_comment_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/post_details/post_detail_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/update_comment/update_comment_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/update_post/update_post_widget.dart';

class TabNavigatorWidget extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItemEnum tabItem;
  const TabNavigatorWidget(
      {super.key, required this.navigatorKey, required this.tabItem});

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
          {Object? arg}) =>
      {
        TabNavigatorRoutes.root: (context) =>
            TabEnums.tabRoots[tabItem] ??
            SafeArea(
              child: Text(tabItem.name),
            ),
        TabNavigatorRoutes.postDetails: (context) =>
            PostDetailWidget.create(arg),
        TabNavigatorRoutes.createComment: (context) =>
            CreateCommentWidget.create(arg),
        TabNavigatorRoutes.updateComment: (context) =>
            UpdateCommentWidget.create(arg),
        TabNavigatorRoutes.updatePost: (context) =>
            UpdatePostWidget.create(arg),
      };

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (settings) {
        Map<String, WidgetBuilder> rb =
            _routeBuilders(context, arg: settings.arguments);
        if (rb.containsKey(settings.name)) {
          return MaterialPageRoute(
            builder: (context) => rb[settings.name]!(context),
          );
        }

        return null;
      },
    );
  }
}
