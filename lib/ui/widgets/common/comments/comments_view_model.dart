import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/post_details/post_detail_model.dart';
import 'package:provider/provider.dart';

class CommentsViewModel extends ChangeNotifier {
  BuildContext context;
  final String _postId;
  final PostService _postService = PostService();

  CommentsViewModel(String postId, {required this.context}) : _postId = postId {
    _asyncInit();

    PostDetailModel postDetailModel = context.read<PostDetailModel>();
    postDetailModel.addListener(() async {
      await _asyncInit();
      notifyListeners();
    });
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

  Future _asyncInit() async {
    try {
      await _postService.syncCommentsForPost(_postId);
      comments = await _postService.getCommentsForPost(_postId);
      comments.sort((a, b) => b.created.compareTo(a.created));
    } on Exception catch (e) {
      exeption = e;
    }
  }

  // Future rebuild() async {
  //   await _acyncInit();
  //   notifyListeners();
  // }
}
