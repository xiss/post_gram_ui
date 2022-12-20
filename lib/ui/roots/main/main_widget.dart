import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/common/posts/posts_view_widget.dart';
import 'package:post_gram_ui/ui/roots/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainViewModel viewModel = context.watch<MainViewModel>();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4),
          child: CircleAvatar(backgroundImage: viewModel.avatar),
        ),
        title: Text(viewModel.name),
        actions: [
          IconButton(
            onPressed: viewModel.profile,
            icon: const Icon(Icons.account_box),
          )
        ],
      ),
      //add post
      body: PostsViewWidget.create(viewModel.posts),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.addPost,
        child: const Icon(Icons.add),
      ),
    );
  }

  static dynamic create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MainViewModel(context: context),
      child: const MainWidget(),
    );
  }
}
