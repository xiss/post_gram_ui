import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/domain/models/comment/update_comment_model.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/update_comment/update_comment_view_model_state.dart';

class UpdateCommentViewModel extends ChangeNotifier {
  BuildContext context;
  final PostService _postService = PostService();
  TextEditingController bodyController = TextEditingController();

  UpdateCommentViewModel({
    required this.context,
    required CommentModel comment,
  }) {
    bodyController.text = comment.body;
    state = state.copyWith(body: comment.body, commentId: comment.id);
    bodyController.addListener(
      () {
        state = state.copyWith(
          body: bodyController.text,
          commentId: comment.id,
        );
      },
    );
  }

  UpdateCommentViewModelState _state = UpdateCommentViewModelState();
  UpdateCommentViewModelState get state {
    return _state;
  }

  set state(UpdateCommentViewModelState value) {
    _state = value;
    notifyListeners();
  }

  bool checkFields() {
    return (state.body?.isNotEmpty ?? false);
  }

  Future updateComment() async {
    String? body = state.body;
    String? commentId = state.commentId;
    if (body != null && commentId != null) {
      UpdateCommentModel model = UpdateCommentModel(
        newBody: body,
        id: commentId,
      );
      await _postService.updateComment(model);
      Navigator.of(context).pop();
    }
    //notifyListeners();
  }

  Future deleteComment() async {
    String? commentId = state.commentId;
    if (commentId != null) {
      await _postService.deleteComment(commentId);
      Navigator.of(context).pop();
    }
  }
}
