import 'package:flutter/cupertino.dart';
import 'package:post_gram_ui/data/services/database_service.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/widgets/roots/create_post/create_post_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_profile/profile/profile_widget.dart';

class HomeViewModel extends ChangeNotifier {
  BuildContext context;
  final DatabaseService _databaseService = DatabaseService();
  final PostService _postService = PostService();

  HomeViewModel({required this.context}) {
    _asyncInit();
  }

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;
  set posts(List<PostModel> value) {
    _posts = value;
    notifyListeners();
  }

  String? _error;
  String? get error => _error;
  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  void _asyncInit() async {
    try {
      await _postService.syncPosts();
      posts = await _databaseService.getPosts();
    } on InnerPostGramException catch (e) {
      error = e.message;
    }
  }

  void profile() {
    ProfileWidget.create();
  }

  Future addPost() async {
    CreatePostWidget.create();
    _asyncInit();
  }
}
