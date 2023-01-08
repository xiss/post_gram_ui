import 'package:flutter/cupertino.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';

class HomeModel extends ChangeNotifier {
  BuildContext context;
  final PostService _postService = PostService();

  HomeModel({required this.context}) {
    _asyncInit();
  }

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;
  set posts(List<PostModel> value) {
    _posts = value;
    notifyListeners();
  }

  Exception? _exeption;
  Exception? get exeption => _exeption;
  set exeption(Exception? exeption) {
    _exeption = exeption;
    notifyListeners();
  }

  Future _asyncInit() async {
    try {
      await _postService.syncPosts();
      posts = await _postService.getPosts();
    } on Exception catch (e) {
      exeption = e;
    }
  }
}
