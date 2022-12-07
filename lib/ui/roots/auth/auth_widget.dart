import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/roots/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: viewModel.loginController,
                enabled: !viewModel.state.isLoading,
                decoration: InputDecoration(
                  hintText: "Enter Login",
                  errorText: viewModel.state.errorLogin,
                ),
              ),
              TextField(
                  controller: viewModel.passwordController,
                  obscureText: true,
                  enabled: !viewModel.state.isLoading,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    errorText: viewModel.state.errorPassword,
                  )),
              ElevatedButton(
                  onPressed:
                      viewModel.checkFields() && !viewModel.state.isLoading
                          ? viewModel.login
                          : null,
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

  static Widget create() => ChangeNotifierProvider<AuthViewModel>(
        create: (context) => AuthViewModel(context: context),
        child: const AuthWidget(),
      );
}
