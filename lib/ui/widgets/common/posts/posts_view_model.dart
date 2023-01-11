import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/widgets/roots/app/app_view_model.dart';
import 'package:provider/provider.dart';

class PostsViewModel extends ChangeNotifier {
  BuildContext context;
  final ScrollController scrollController = ScrollController();
  AppViewModel? _appViewModel;

  PostsViewModel(this._posts, {required this.context}) {
    scrollController.addListener(() {
      //TODO подгрузка постов по дате когда переделаю метод на бэке
      notifyListeners();
    });
    _appViewModel = context.read<AppViewModel>();
    _appViewModel?.addListener(() {
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
