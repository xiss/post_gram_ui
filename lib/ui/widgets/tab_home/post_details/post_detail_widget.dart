import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/widgets/common/comments/comments_view_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/post/post_view_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/post_details/post_detail_view_model.dart';
import 'package:provider/provider.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PostDetailViewModel viewModel = context.watch();
    PostModel? postModel = viewModel.post;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => viewModel.createComment(postModel?.id),
      ),
      body: ListView(
        //shrinkWrap: true,
        children: [
          postModel != null
              ? PostViewWidget.create(postModel, false)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
//TODO Работает из за того что мы создаем виджет когда список уже есть, похоже это не правильно
// здесь не нужна эта проверка
          viewModel.comments.isNotEmpty
              ? CommentsViewWidget.create(viewModel.comments)
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

    return ChangeNotifierProvider<PostDetailViewModel>(
      create: (BuildContext context) =>
          PostDetailViewModel(context: context, postId: postId),
      child: const PostDetailWidget(),
    );
  }
}
