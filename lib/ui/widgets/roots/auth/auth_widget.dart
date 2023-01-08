import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/roots/auth/auth_model.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<AuthModel>();

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
                ),
              ),

              //login button
              ElevatedButton(
                onPressed: viewModel.checkFields() && !viewModel.state.isLoading
                    ? viewModel.login
                    : null,
                child: const Text("Login"),
              ),

              //registration button
              ElevatedButton(
                onPressed: viewModel.toRegistration,
                child: const Text("Registration"),
              ),
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

  static Widget create() => ChangeNotifierProvider<AuthModel>(
        create: (context) => AuthModel(context: context),
        child: const AuthWidget(),
      );
}
