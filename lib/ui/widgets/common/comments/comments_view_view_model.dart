import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';

class CommentsViewViewModel extends ChangeNotifier {
  BuildContext context;
  Map<CommentModel, CommentModel?> commentsMap = {};

  CommentsViewViewModel(List<CommentModel> comments, {required this.context}) {
    for (CommentModel comment in comments) {
      if (comment.quotedCommentId != null) {
        commentsMap[comment] = comments.firstWhereOrNull(
          (element) => element.id == comment.quotedCommentId,
        );
      } else {
        commentsMap[comment] = null;
      }
    }

    notifyListeners();
  }
}
