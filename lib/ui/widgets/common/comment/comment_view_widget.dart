import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/ui/widgets/common/author_header_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/comment/comment_view_model.dart';
import 'package:post_gram_ui/ui/widgets/common/error_post_gram_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/styles/font_styles.dart';
import 'package:provider/provider.dart';

class CommentViewWidget extends StatelessWidget {
  const CommentViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CommentViewModel viewModel = context.watch<CommentViewModel>();
    CommentModel? comment = viewModel.comment;
    Widget result;
    if (viewModel.exeption != null) {
      return ErrorPostGramWidget(viewModel.exeption!);
    }
    if (comment != null) {
      result = Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthorHeaderWidget(
              avatar: viewModel.avatar,
              name: comment.author.nickname,
              created: comment.created,
              edited: comment.edited,
            ),
            //quotedText
            comment.quotedText != null
                ? Text(
                    viewModel.quote,
                    style: FontStyles.getSmallTextStyle(),
                  )
                : const SizedBox.shrink(),
            //comment
            Text(
              comment.body,
              style: FontStyles.getMainTextStyle(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //reply button
                TextButton.icon(
                  onPressed: viewModel.createComment,
                  icon: const Icon(Icons.reply),
                  label: const Text("Reply"),
                ),
                // update button
                TextButton.icon(
                  onPressed: comment.author.id == viewModel.currentUser?.id
                      ? viewModel.updateComment
                      : null,
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                ),
                //likes
                TextButton.icon(
                  onPressed: () => viewModel.createUpdateLike(true),
                  icon: Icon(
                      color: comment.likeByUser?.isLike == true
                          ? Colors.red
                          : null,
                      Icons.thumb_up),
                  label: Text(comment.likeCount.toString()),
                ),
                //dislikes
                TextButton.icon(
                  onPressed: () => viewModel.createUpdateLike(false),
                  icon: Icon(
                      color: comment.likeByUser?.isLike == false
                          ? Colors.red
                          : null,
                      Icons.thumb_down),
                  label: Text(comment.dislikeCount.toString()),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      result = const Center(
        child: CircularProgressIndicator(),
      );
    }
    return result;
  }

  static dynamic create(String commentId) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CommentViewModel(
        commentId: commentId,
        context: context,
      ),
      child: const CommentViewWidget(),
    );
  }
}
