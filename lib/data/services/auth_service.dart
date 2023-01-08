import 'dart:io';
import 'package:dio/dio.dart';
import 'package:post_gram_ui/data/repositories/database_repository.dart';
import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/auth/token_response.dart';
import 'package:post_gram_ui/domain/models/user/user_create_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/internal/configs/token_storage.dart';
import 'package:post_gram_ui/internal/dependencies/repository_module.dart';

class AuthService {
  final ApiRepositoryBase _apiRepository = RepositoryModule.apiReposytory();
  final UserService _userService = UserService();
  static final DatabaseRepository _database = DatabaseRepository.instance;

  Future auth(String? login, String? password) async {
    if (login != null && password != null) {
      try {
        TokenResponseModel? token =
            await _apiRepository.getToken(login: login, password: password);
        if (token != null) {
          await TokenStorage.setStoredToken(token);
          _userService.syncCurrentUser();
        }
      } on DioError catch (e) {
        if (e.error is SocketException) {
          throw const NoNetworkPostGramException();
        } else if (e.response?.statusCode == 401 ||
            e.response?.statusCode == 403) {
          throw const WrongCredentionalPostGramException();
        } else if (e.response?.statusCode == 404) {
          throw const NotFoundPostGramException();
        }
      } catch (e) {
        throw const InternalServerPostGramException();
      }
    }
  }

  Future<bool> checkAuth() async {
    bool result = false;
    if ((await TokenStorage.getSecurityToken()) != null) {
      UserModel? user = await _apiRepository.getCurrentUser();
      if (user != null) {
        await SharedPreferencesHelper.setStoredUser(user);
        result = true;
      }
    }
    return result;
  }

  Future logout() async {
    await TokenStorage.setStoredToken(null);
  }

  Future<dynamic> registerUser(UserCreateModel model) async {
    try {
      return await _apiRepository.registerUser(model);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      } else if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403) {
        throw const WrongCredentionalPostGramException();
      } else if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException();
      } else if (e.response?.statusCode == 400 &&
          e.response?.data['errors'] != null) {
        throw ValidationPostGramException(e.response?.data);
      }
    } catch (e) {
      throw const InnerPostGramException();
    }
  }

  Future clearDatabase() async {
    await _database.clearDatabase();
  }
}
