import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/roots/registration/registration_view_model.dart';
import 'package:provider/provider.dart';

class RegistrationWidget extends StatelessWidget {
  const RegistrationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<RegistrationViewModel>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: viewModel.emailController,
                    enabled: !viewModel.state.isLoading,
                    decoration: InputDecoration(
                      labelText: "Enter email*",
                      errorText: viewModel.state.errorEmail,
                    ),
                  ),
                  TextField(
                    controller: viewModel.passwordController,
                    enabled: !viewModel.state.isLoading,
                    decoration: InputDecoration(
                      labelText: "Enter password*",
                      errorText: viewModel.state.errorPassword,
                    ),
                  ),
                  TextField(
                      controller: viewModel.passwordRetryController,
                      obscureText: true,
                      enabled: !viewModel.state.isLoading,
                      decoration: InputDecoration(
                        labelText: "Confirm password*",
                        errorText: viewModel.state.errorPassword,
                      )),
                  //TODO bithdate and private
                  TextField(
                    controller: viewModel.patronymicController,
                    enabled: !viewModel.state.isLoading,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Enter patronymic",
                    ),
                  ),
                  TextField(
                    controller: viewModel.surnameController,
                    enabled: !viewModel.state.isLoading,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Enter surname",
                    ),
                  ),
                  TextField(
                    controller: viewModel.nameController,
                    enabled: !viewModel.state.isLoading,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Enter name",
                    ),
                  ),
                  TextField(
                    controller: viewModel.nicknameController,
                    enabled: !viewModel.state.isLoading,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Enter nickname",
                    ),
                  ),
                  ElevatedButton(
                    onPressed:
                        viewModel.checkFields() && !viewModel.state.isLoading
                            ? viewModel.register
                            : null,
                    child: const Text("Register"),
                  ),
                  if (viewModel.state.isLoading)
                    const CircularProgressIndicator(),
                  if (viewModel.state.errorText != null)
                    Text(
                      viewModel.state.errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<RegistrationViewModel>(
        create: (context) => RegistrationViewModel(context: context),
        child: const RegistrationWidget(),
      );
}
