import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/enums/tab_item.dart';
import 'package:post_gram_ui/ui/navigation/tab_enums.dart';
import 'package:post_gram_ui/ui/navigation/tab_navigator.dart';
import 'package:post_gram_ui/ui/widgets/common/bottom_tabs_widget.dart';
import 'package:post_gram_ui/ui/widgets/roots/app/app_view_model.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppViewModel viewModel = context.watch<AppViewModel>();

    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: WillPopScope(
        onWillPop: () async {
          bool isFirstRouteInCurrentTab = !await viewModel
              .navigationKeys[viewModel.currentTab]!.currentState!
              .maybePop();
          if (isFirstRouteInCurrentTab) {
            if (viewModel.currentTab != TabEnums.defaultTab) {
              viewModel.selectTab(TabEnums.defaultTab);
            }
            return false;
          }
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          bottomNavigationBar: BottomTabsWidget(
            currentTab: viewModel.currentTab,
            onSelectTab: viewModel.selectTab,
          ),
          body: Stack(
            children: TabItemEnum.values
                .map((e) => _buildOffStageNavigator(context, e))
                .toList(),
          ),
        ),
      ),
    );
  }

  static dynamic create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppViewModel(context: context),
      child: const AppWidget(),
    );
  }
}

Widget _buildOffStageNavigator(BuildContext context, TabItemEnum item) {
  AppViewModel viewModel = context.watch<AppViewModel>();
  return Offstage(
    offstage: viewModel.currentTab != item,
    child: TabNavigator(
      navigatorKey: viewModel.navigationKeys[item]!,
      tabItem: item,
    ),
  );
}
