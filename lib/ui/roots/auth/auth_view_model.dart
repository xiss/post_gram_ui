import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';
import 'package:post_gram_ui/ui/roots/auth/auth_view_model_state.dart';

class AuthViewModel extends ChangeNotifier {
  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  final _authService = AuthService();

  BuildContext context;
  AuthViewModel({required this.context}) {
    loginController.addListener(() {
      state = state.copyWith(login: loginController.text);
    });
    passwordController.addListener(() {
      state = state.copyWith(password: passwordController.text);
    });
  }

  var _state = const AuthViewModelState();
  AuthViewModelState get state {
    return _state;
  }

  set state(AuthViewModelState value) {
    _state = value;
    notifyListeners();
  }

  bool checkFields() {
    return (state.login?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false);
  }

  void login() async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService
          .auth(state.login, state.password)
          .then((value) => AppNavigator.toLoader());
    } on WrongCredentionalPostGramException {
      state = state.copyWith(errorPassword: "Incorrect password");
    } on NoNetworkPostGramException {
      state = state.copyWith(errorText: "Not network connection");
    } on NotFoundPostGramException {
      state = state.copyWith(errorLogin: "Login not found");
    } catch (e) {
      state = state.copyWith(errorText: "Internal error");
    }
  }
}
