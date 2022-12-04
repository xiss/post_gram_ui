import 'package:dio/dio.dart';
import 'package:post_gram_ui/data/clients/api_client.dart';
import 'package:post_gram_ui/data/clients/auth_client.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/domain/models/auth/refresh_token_request_model.dart';
import 'package:post_gram_ui/domain/models/auth/token_response.dart';
import 'package:post_gram_ui/internal/configs/app_config.dart';
import 'package:post_gram_ui/internal/configs/token_storage.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';

class ApiModule {
  static AuthClient? _authClient;
  static ApiClient? _apiClient;

  static AuthClient auth() {
    return _authClient ?? AuthClient(Dio(), baseUrl: baseUrl);
  }

  static ApiClient api() {
    return _apiClient ?? ApiClient(_addInterseptors(Dio()), baseUrl: baseUrl);
  }

  static Dio _addInterseptors(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getSecurityToken();
        options.headers.addAll({"Authorization": "Bearer $token"});
        return handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          // ignore: deprecated_member_use
          dio.lock(); //TODO update

          RequestOptions options = e.response!.requestOptions;

          String? refreshToken = await TokenStorage.getRefreshToken();
          try {
            if (refreshToken != null) {
              TokenResponseModel? token = await auth().getTokenByRefreshToken(
                  RefreshTokenRequestModel(refreshToken: refreshToken));
              await TokenStorage.setStoredToken(token);
              options.headers["Authorization"] = "Bearer $token.securityToken";
            }
          } catch (e) {
            AuthService authService = AuthService();
            if (await authService.checkAuth()) {
              await authService.logout();
              AppNavigator.toLoader();
            }
            return handler
                .resolve(Response(requestOptions: options, statusCode: 400));
          } finally {
            dio.unlock();
          }

          return handler.resolve(await dio.fetch(options));
        } else {
          return handler.next(e);
        }
      },
    ));
    return dio;
  }
}
