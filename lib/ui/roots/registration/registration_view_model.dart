import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/data/services/database_service.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/user/user_create_model.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';
import 'package:post_gram_ui/ui/roots/registration/registration_view_model_state.dart';

class RegistrationViewModel extends ChangeNotifier {
  BuildContext context;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController isPrivateController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  final AuthService _authService = AuthService();
  RegistrationViewModel({required this.context}) {
    passwordController.addListener(() {
      state = state.copyWith(password: passwordController.text);
    });
    passwordRetryController.addListener(() {
      state = state.copyWith(passwordRetry: passwordRetryController.text);
    });
    emailController.addListener(() {
      state = state.copyWith(email: emailController.text);
    });
    nameController.addListener(() {
      state = state.copyWith(name: nameController.text);
    });
    patronymicController.addListener(() {
      state = state.copyWith(patronymic: patronymicController.text);
    });
    surnameController.addListener(() {
      state = state.copyWith(surname: surnameController.text);
    });
    nicknameController.addListener(() {
      state = state.copyWith(nickname: nicknameController.text);
    });
  }

  RegistrationViewModelState _state = RegistrationViewModelState();
  RegistrationViewModelState get state {
    return _state;
  }

  set state(RegistrationViewModelState value) {
    _state = value;
    notifyListeners();
  }

  bool checkFields() {
    return (state.email?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false) &&
        (state.passwordRetry?.isNotEmpty ?? false);
  }

  void register() async {
    state = state.copyWith(isLoading: true);
    String? email = state.email;
    String? passwordRetry = state.passwordRetry;
    String? password = state.password;
    if (password != passwordRetry) {
      state = state.copyWith(
          isLoading: false, errorPassword: "Passwords is not equial");
      return;
    }

    if (email != null && password != null && passwordRetry != null) {
      UserCreateModel model = UserCreateModel(
          birthDate: state.birthDate,
          email: email,
          isPrivate: state.isPrivate ?? true,
          name: state.name ?? "",
          nickname: state.nickname ?? "",
          password: password,
          passwordRetry: passwordRetry,
          patronymic: state.patronymic ?? "",
          surname: state.surname ?? "");

      try {
        await _authService.registerUser(model);
        //state = state.copyWith(isLoading: false);
        //.then((value) => AppNavigator.toLoader());
        await DatabaseService().clearDatabase();
        await _authService.auth(state.email, state.password);
        AppNavigator.toMain();
      } on NoNetworkPostGramException {
        state = state.copyWith(errorText: "Not network connection");
      } on ValidationPostGramException catch (e) {
        if (e.data['errors']['Email'] != null) {
          state =
              state.copyWith(errorEmail: e.data['errors']['Email'].toString());
        }
        if (e.data['errors']['Password'] != null) {
          state = state.copyWith(
              errorPassword: e.data['errors']['Password'].toString());
        } else {
          state = state.copyWith(errorText: e.data['errors'].toString());
        }
      } catch (e) {
        state = state.copyWith(errorText: "Internal error");
      } finally {
        state = state.copyWith(isLoading: false);
      }
    }
  }
}
