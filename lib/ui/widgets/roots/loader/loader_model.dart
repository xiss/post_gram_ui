import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/ui/navigation/app_navigator.dart';

class LoaderModel extends ChangeNotifier {
  final _authService = AuthService();

  BuildContext context;
  LoaderModel({required this.context}) {
    _asyncInit();
  }

  void _asyncInit() async {
    if (await _authService.checkAuth()) {
      AppNavigator.toApp();
    } else {
      AppNavigator.toAuth();
    }
  }
}
