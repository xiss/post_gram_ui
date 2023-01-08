import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/comment/create_comment_model.dart';
import 'package:post_gram_ui/ui/widgets/common/comments/comments_view_model.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/create_comment/create_comment_model_state.dart';

class CreateCommentViewModel extends ChangeNotifier {
  BuildContext context;
  final PostService _postService = PostService();
  CommentsViewModel? _commentsViewModel;

  TextEditingController bodyController = TextEditingController();
  TextEditingController quoteController = TextEditingController();
  FocusNode quoteFocusNode = FocusNode();

  CreateCommentViewModel(
    String? quoteSource, {
    required this.context,
    required String postId,
    String? quotedCommentId,
  }) {
    state = CreateCommentModelState(
      postId: postId,
      quoteCommentId: quotedCommentId,
      quoteSource: quoteSource,
    );

    bodyController.addListener(() {
      state = state.copyWith(body: bodyController.text);
    });

    if (quoteSource != null) {
      quoteController.text = quoteSource;
      state = state.copyWith(quote: "");

      quoteFocusNode.addListener(
        () {
          String quote = quoteController.text.substring(
            quoteController.selection.start,
            quoteController.selection.end,
          );

          state = state.copyWith(
            quote: quote,
          );
        },
      );
    }
  }

  CreateCommentModelState _state = CreateCommentModelState();
  CreateCommentModelState get state {
    return _state;
  }

  set state(CreateCommentModelState value) {
    _state = value;
    notifyListeners();
  }

  bool checkFields() {
    return (state.body?.isNotEmpty ?? false);
  }

  Future addComment() async {
    String? body = state.body;
    String? postId = state.postId;
    if (body != null && postId != null) {
      CreateCommentModel model = CreateCommentModel(
        body: body,
        postId: postId,
        quotedCommentId: state.quoteCommentId,
        quotedText: state.quote,
      );
      try {
        await _postService.createComment(model);
        await _postService.syncCommentsForPost(postId);
        await _postService.syncPost(postId);
      } on Exception catch (e) {
        state = state.copyWith(exeption: e);
      }

      Navigator.of(context).pop();
    }
    _commentsViewModel?.notifyListeners();
    notifyListeners();
  }
}
