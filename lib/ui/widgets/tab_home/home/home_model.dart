import 'package:flutter/cupertino.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/widgets/roots/app/app_view_model.dart';
import 'package:provider/provider.dart';

class HomeModel extends ChangeNotifier {
  BuildContext context;
  final PostService _postService = PostService();
  AppViewModel? _appViewModel;

  HomeModel({required this.context}) {
    _asyncInit();
    _appViewModel = context.read<AppViewModel>();
    _appViewModel?.addListener(() {
      _asyncInit();
    });
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
