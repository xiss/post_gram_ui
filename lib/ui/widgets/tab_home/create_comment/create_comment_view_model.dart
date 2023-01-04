import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/comment/create_comment_model.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/create_comment/create_comment_view_model_state.dart';

class CreateCommentViewModel extends ChangeNotifier {
  BuildContext context;
  final PostService _postService = PostService();

  TextEditingController bodyController = TextEditingController();
  TextEditingController quoteController = TextEditingController();
  FocusNode quoteFocusNode = FocusNode();

  CreateCommentViewModel(
    String? quoteSource, {
    required this.context,
    required String postId,
    String? quotedCommentId,
  }) {
    state = CreateCommentViewModelState(
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

  CreateCommentViewModelState _state = CreateCommentViewModelState();
  CreateCommentViewModelState get state {
    return _state;
  }

  set state(CreateCommentViewModelState value) {
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
      await _postService.createComment(model);
      await _postService.syncCommentsForPost(postId);
      Navigator.of(context).pop();
    }
    notifyListeners();
  }
}
