import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/navigation/tab_navigator_routes.dart';

class PostDetailModel extends ChangeNotifier {
  final BuildContext context;
  final PostService _postService = PostService();
  final String postId;

  PostDetailModel({
    required this.context,
    required this.postId,
  }) {
    _acyncInit();
  }

  PostModel? _post;
  PostModel? get post => _post;
  set post(PostModel? post) {
    _post = post;
    notifyListeners();
  }

  Exception? _exeption;
  Exception? get exeption => _exeption;
  set exeption(Exception? exeption) {
    _exeption = exeption;
    notifyListeners();
  }

  List<CommentModel> _comments = [];
  List<CommentModel> get comments => _comments;
  set comments(List<CommentModel> comments) {
    _comments = comments;
    notifyListeners();
  }

  Future _acyncInit() async {
    try {
      await _postService.syncPost(postId);
      await _postService.syncCommentsForPost(postId);
      post = await _postService.getPost(postId);
      comments = await _postService.getCommentsForPost(postId);
    } on Exception catch (e) {
      exeption = e;
    }
  }

  Future createComment(String? postId) async {
    await Navigator.of(context).pushNamed(
      TabNavigatorRoutes.createComment,
      arguments: [
        postId,
      ],
    );
    await _acyncInit();
    notifyListeners();
  }
}
