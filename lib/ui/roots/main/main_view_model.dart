import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/database_service.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';

class MainViewModel extends ChangeNotifier {
  BuildContext context;
  final DatabaseService _databaseService = DatabaseService();
  final AttachmentService _attachmentService = AttachmentService();
  final PostService _postService = PostService();

  MainViewModel({required this.context}) {
    _asyncInit();
  }

  String _name = "";
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  NetworkImage? _avatar;
  NetworkImage? get avatar => _avatar;
  set avatar(NetworkImage? value) {
    _avatar = value;
    notifyListeners();
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
    UserModel? user = await SharedPreferencesHelper.getStoredUser();
    if (user != null) {
      name = "${user.name} (${user.nickname})";

      AttachmentModel? avatarL = user.avatar;
      if (avatarL != null) {
        avatar = await _attachmentService.getAttachment(avatarL.link);
      }
    }
    try {
      await _postService.syncPosts();
      posts = await _databaseService.getPosts();
    } on InnerPostGramException catch (e) {
      error = e.message;
    }
  }

  void profile() {
    AppNavigator.toProfile();
  }

  Future addPost() async {
    await AppNavigator.toAddPost();
    _asyncInit();
  }
}
