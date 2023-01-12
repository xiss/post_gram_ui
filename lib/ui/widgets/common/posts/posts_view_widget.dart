import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/widgets/common/post/post_view_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/posts/posts_view_model.dart';
import 'package:provider/provider.dart';

class PostsViewWidget extends StatelessWidget {
  final List<PostModel> _posts;

  const PostsViewWidget(this._posts, {super.key});

  static dynamic create(List<PostModel> posts) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PostsViewModel(posts, context: context),
      child: PostsViewWidget(posts),
    );
  }

  @override
  Widget build(BuildContext context) {
    PostsViewModel viewModel = context.watch<PostsViewModel>();
    if (_posts.isEmpty) {
      return const Center(
          child: Text("Posts not found. Subscribe for someone."));
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.separated(
                controller: viewModel.scrollController,
                itemBuilder: (_, index) {
                  return PostViewWidget.create(_posts[index].id, false);
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: _posts.length),
          ),
          if (viewModel.isLoading) const LinearProgressIndicator()
        ],
      );
    }
  }
}
