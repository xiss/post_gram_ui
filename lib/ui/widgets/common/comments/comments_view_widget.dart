import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/common/comment/comment_view_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/comments/comments_view_model.dart';
import 'package:post_gram_ui/ui/widgets/common/error_post_gram_widget.dart';
import 'package:provider/provider.dart';

class CommentsViewWidget extends StatelessWidget {
  const CommentsViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CommentsViewModel viewModel = context.watch<CommentsViewModel>();

    if (viewModel.exeption != null) {
      return ErrorPostGramWidget(viewModel.exeption!);
    }
    if (viewModel.comments.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Column(
        children: _getComments(viewModel),
      );
    }
  }

  List<Widget> _getComments(CommentsViewModel model) {
    List<Widget> result = [];
    for (var comment in model.comments) {
      result.add(const Divider());
      result.add(CommentViewWidget.create(comment.id));
    }
    return result;
  }

  static dynamic create(String postId) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          CommentsViewModel(postId, context: context),
      child: const CommentsViewWidget(),
    );
  }
}
