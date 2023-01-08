import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';

class PostsViewModel extends ChangeNotifier {
  BuildContext context;
  final ScrollController scrollController = ScrollController();

  PostsViewModel(this._posts, {required this.context}) {
    scrollController.addListener(() {
      //TODO подгрузка постов по дате когда переделаю метод на бэке
      notifyListeners();
    });
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<PostModel> _posts;
  List<PostModel> get posts => _posts;
  set posts(List<PostModel> posts) {
    _posts = posts;
    notifyListeners();
  }
}
