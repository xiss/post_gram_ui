import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';

class LoaderViewModel extends ChangeNotifier {
  final _authService = AuthService();

  BuildContext context;
  LoaderViewModel({required this.context}) {
    _asyncInit();
  }

  void _asyncInit() async {
    if (await _authService.checkAuth()) {
      AppNavigator.toMain();
    } else {
      AppNavigator.toAuth();
    }
  }
}
