import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/ui/widgets/common/author_header_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/comment/comment_view_view_model.dart';
import 'package:post_gram_ui/ui/widgets/common/styles/font_styles.dart';
import 'package:provider/provider.dart';

class CommentViewWidget extends StatefulWidget {
  const CommentViewWidget({super.key});

  @override
  State<CommentViewWidget> createState() => _CommentViewWidgetState();

  static dynamic create(CommentModel comment, CommentModel? quotedComment) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CommentViewViewModel(
        comment,
        quotedComment: quotedComment,
        context: context,
      ),
      child: const CommentViewWidget(),
    );
  }
}

class _CommentViewWidgetState extends State<CommentViewWidget> {
  @override
  Widget build(BuildContext context) {
    CommentViewViewModel viewModel = context.watch<CommentViewViewModel>();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthorHeaderWidget(
            avatar: viewModel.avatar,
            name: viewModel.comment.author.nickname,
            created: viewModel.comment.created,
            edited: viewModel.comment.edited,
          ),
          //quotedText
          viewModel.comment.quotedText != null
              ? Text(
                  viewModel.quote,
                  style: FontStyles.getSmallTextStyle(),
                )
              : const SizedBox.shrink(),
          //comment
          Text(
            viewModel.comment.body,
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
                onPressed:
                    viewModel.comment.author.id == viewModel.currentUser?.id
                        ? viewModel.updateComment
                        : null,
                icon: const Icon(Icons.edit),
                label: const Text("Edit"),
              ),
              //likes
              TextButton.icon(
                onPressed: () => viewModel.createUpdateLike(true),
                icon: Icon(
                    color: viewModel.comment.likeByUser?.isLike == true
                        ? Colors.red
                        : null,
                    Icons.thumb_up),
                label: Text(viewModel.comment.likeCount.toString()),
              ),
              //dislikes
              TextButton.icon(
                onPressed: () => viewModel.createUpdateLike(false),
                icon: Icon(
                    color: viewModel.comment.likeByUser?.isLike == false
                        ? Colors.red
                        : null,
                    Icons.thumb_down),
                label: Text(viewModel.comment.dislikeCount.toString()),
              ),
            ],
          )
        ],
      ),
    );
  }
}
