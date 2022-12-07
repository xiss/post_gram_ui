import 'dart:io';
import 'package:dio/dio.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/auth/token_response.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/internal/configs/token_storage.dart';
import 'package:post_gram_ui/internal/dependencies/repository_module.dart';

class AuthService {
  final ApiRepositoryBase _apiRepository = RepositoryModule.apiReposytory();

  Future auth(String? login, String? password) async {
    if (login != null && password != null) {
      try {
        TokenResponseModel? token =
            await _apiRepository.getToken(login: login, password: password);
        if (token != null) {
          await TokenStorage.setStoredToken(token);
          UserModel? userModel = await _apiRepository.getCurrentUser();
          if (userModel != null) {
            await SharedPreferencesHelper.setStoredUser(userModel);
          }
        }
      } on DioError catch (e) {
        if (e.error is SocketException) {
          throw NoNetworkPostGramException();
        } else if (e.response?.statusCode == 401 ||
            e.response?.statusCode == 403) {
          throw WrongCredentionalPostGramException();
        } else if (e.response?.statusCode == 404) {
          throw NotFoundPostGramException();
        }
      } catch (e) {
        throw InternalServerPostGramException();
      }
    }
  }

  Future<bool> checkAuth() async {
    //TODO надо проверить токен передд тем как его отдавать
    return (await TokenStorage.getSecurityToken()) != null &&
        (await SharedPreferencesHelper.getStoredUser() != null);
  }

  Future logout() async {
    await TokenStorage.setStoredToken(null);
  }
}
