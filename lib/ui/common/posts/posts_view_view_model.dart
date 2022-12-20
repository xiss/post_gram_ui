import 'package:flutter/material.dart';

class PostsViewViewModel extends ChangeNotifier {
  BuildContext context;
  final ScrollController scrollController = ScrollController();
  PostsViewViewModel({required this.context}) {
    scrollController.addListener(() {
      //TODO подгрузка постов когда переделаю метод на бэке
    });
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
