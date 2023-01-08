import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/widgets/common/comments/comments_view_model.dart';
import 'package:post_gram_ui/ui/widgets/common/comments/comments_view_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/post/post_view_model.dart';
import 'package:post_gram_ui/ui/widgets/common/post/post_view_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/post_details/post_detail_model.dart';
import 'package:provider/provider.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PostDetailModel viewModel = context.watch<PostDetailModel>();
    PostModel? postModel = viewModel.post;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => viewModel.createComment(postModel?.id),
      ),
      body: ListView(
        children: [
          postModel != null
              ? PostViewWidget.create(postModel.id, false)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          viewModel.comments.isNotEmpty
              ? CommentsViewWidget.create(viewModel.postId)
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  static dynamic create(Object? arg) {
    String postId = "";
    if (arg != null && arg is String) {
      postId = arg;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                PostDetailModel(context: context, postId: postId)),
        ChangeNotifierProvider(
            create: (context) => CommentsViewModel(postId, context: context)),
        ChangeNotifierProvider(
            create: (context) =>
                PostViewModel(postId, false, context: context)),
      ],
      child: const PostDetailWidget(),
    );
  }
}
