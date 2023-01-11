import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/domain/models/comment/update_comment_model.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/update_comment/update_comment_model_state.dart';

class UpdateCommentViewModel extends ChangeNotifier {
  BuildContext context;
  final PostService _postService = PostService();
  TextEditingController bodyController = TextEditingController();
  //CommentsViewModel? _postDetailModel;

  UpdateCommentViewModel({
    required this.context,
    required CommentModel comment,
  }) {
    bodyController.text = comment.body;
    state = state.copyWith(
      body: comment.body,
      commentId: comment.id,
      postId: comment.postId,
    );

    bodyController.addListener(
      () {
        state = state.copyWith(
          body: bodyController.text,
          commentId: comment.id,
        );
      },
    );
    //_postDetailModel = context.read<CommentsViewModel>();
  }

  UpdateCommentModelState _state = UpdateCommentModelState();
  UpdateCommentModelState get state {
    return _state;
  }

  set state(UpdateCommentModelState value) {
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
      try {
        await _postService.updateComment(model);
        await _postService.syncComment(commentId);
      } on Exception catch (e) {
        state = state.copyWith(exeption: e);
      }

      Navigator.of(context).pop();
    }
  }

  Future deleteComment() async {
    String? commentId = state.commentId;
    String? postId = state.postId;
    if (commentId != null && postId != null) {
      try {
        await _postService.deleteComment(commentId);
        await _postService.syncPost(postId);
      } on Exception catch (e) {
        state = state.copyWith(exeption: e);
      }

      Navigator.of(context).pop(true);
    }
  }
}
