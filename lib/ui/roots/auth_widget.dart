import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:provider/provider.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';

class _ViewModelState {
  final String? login;
  final String? password;
  final bool isLoading;
  final String? errorText;

  const _ViewModelState({
    this.login,
    this.password,
    this.isLoading = false,
    this.errorText,
  });

  _ViewModelState copyWith({
    String? login,
    String? password,
    bool? isLoading = false,
    String? errorText,
  }) {
    return _ViewModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText ?? this.errorText,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  final _authService = AuthService();

  BuildContext context;
  _ViewModel({required this.context}) {
    loginController.addListener(() {
      state = state.copyWith(login: loginController.text);
    });
    passwordController.addListener(() {
      state = state.copyWith(password: passwordController.text);
    });
  }

  var _state = const _ViewModelState();
  _ViewModelState get state {
    return _state;
  }

  set state(_ViewModelState value) {
    _state = value;
    notifyListeners();
  }

  bool checkFields() {
    return (state.login?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false);
  }

  void login() async {
    state = state.copyWith(isLoading: true);
//TODO надо блокировать интерфейс на время ожидания ответа
    try {
      await _authService
          .auth(state.login, state.password)
          .then((value) => AppNavigator.toLoader());
    } on WrongCredentionalPostGramException {
      state = state.copyWith(errorText: "Incorrect password");
    } on NoNetworkPostGramException {
      state = state.copyWith(errorText: "Not network connection");
    } on NotFoundPostGramException {
      state = state.copyWith(errorText: "Login not found");
    } catch (e) {
      state = state.copyWith(errorText: "Internal error");
    }
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: viewModel.loginController,
                decoration: const InputDecoration(hintText: "Enter Login"),
              ),
              TextField(
                  controller: viewModel.passwordController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(hintText: "Enter Password")),
              ElevatedButton(
                  onPressed: viewModel.checkFields() ? viewModel.login : null,
                  child: const Text("Login")),
              if (viewModel.state.isLoading) const CircularProgressIndicator(),
              if (viewModel.state.errorText != null)
                Text(
                  viewModel.state.errorText!,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<_ViewModel>(
        create: (context) => _ViewModel(context: context),
        child: const AuthWidget(),
      );
}
