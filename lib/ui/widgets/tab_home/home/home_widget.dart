import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/common/posts/posts_view_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = context.watch<HomeViewModel>();

    return SafeArea(child: PostsViewWidget.create(viewModel.posts));
  }

  static dynamic create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeViewModel(context: context),
      child: const HomeWidget(),
    );
  }
}
