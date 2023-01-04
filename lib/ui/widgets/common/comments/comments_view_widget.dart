import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/ui/widgets/common/comment/comment_view_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/comments/comments_view_view_model.dart';
import 'package:provider/provider.dart';

class CommentsViewWidget extends StatefulWidget {
  const CommentsViewWidget({super.key});

  @override
  State<CommentsViewWidget> createState() => _CommentsViewWidgetState();

  static dynamic create(List<CommentModel> comments) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          CommentsViewViewModel(comments, context: context),
      child: const CommentsViewWidget(),
    );
  }
}

class _CommentsViewWidgetState extends State<CommentsViewWidget> {
  @override
  Widget build(BuildContext context) {
    CommentsViewViewModel viewModel = context.watch<CommentsViewViewModel>();
    if (viewModel.commentsMap.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Column(
        children: getComments(viewModel.commentsMap),
      );
    }
  }

  List<Widget> getComments(Map<CommentModel, CommentModel?> comments) {
    List<Widget> result = [];
    for (var comment in comments.keys) {
      result.add(const Divider());
      result.add(CommentViewWidget.create(comment, comments[comment]));
    }
    return result;
  }
}
