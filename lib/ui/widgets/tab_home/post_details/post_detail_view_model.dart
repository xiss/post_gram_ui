import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/navigation/tab_navigator_routes.dart';

class PostDetailViewModel extends ChangeNotifier {
  BuildContext context;
  final PostService _postService = PostService();

  final String postId;
  PostModel? post;
  List<CommentModel> comments = [];

  PostDetailViewModel({
    required this.context,
    required this.postId,
  }) {
    _acyncInit(postId);
  }

  Future _acyncInit(String postId) async {
    try {
      await _postService.syncCommentsForPost(postId);
      post = await _postService.getPost(postId);
      comments = await _postService.getCommentsForPost(postId);
      notifyListeners(); //Нужно убрать в свойства во всех моделях
    } catch (e) {
      //var a = 1;
      //TODO обработка ошибок
    }
  }

  Future createComment(
    String? postId,
  ) async {
    await Navigator.of(context).pushNamed(
      TabNavigatorRoutes.createComment,
      arguments: [
        postId,
      ],
    );
    notifyListeners(); //TODO тут нужно?
  }
}
