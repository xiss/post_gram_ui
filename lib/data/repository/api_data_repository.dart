import 'package:post_gram_ui/data/clients/api_client.dart';
import 'package:post_gram_ui/data/clients/auth_client.dart';
import 'package:post_gram_ui/domain/models/auth/refresh_token_request_model.dart';
import 'package:post_gram_ui/domain/models/auth/token_request_model.dart';
import 'package:post_gram_ui/domain/models/auth/token_response.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';

class ApiDataRepository extends ApiRepositoryBase {
  final AuthClient _authClient;
  final ApiClient _apiClient;

  ApiDataRepository(this._authClient, this._apiClient);

  @override
  Future<TokenResponseModel?> getToken({
    required String login,
    required String password,
  }) async {
    return await _authClient.getToken(TokenRequestModel(
      login: login,
      password: password,
    ));
  }

  @override
  Future<UserModel?> getCurrentUser() {
    return _apiClient.getCurrentUser();
  }

  @override
  Future<TokenResponseModel?> getTokenByRefreshToken(
      String refreshToken) async {
    return await _authClient.getTokenByRefreshToken(
        RefreshTokenRequestModel(refreshToken: refreshToken));
  }

  @override
  Future<List<SubscriptionModel>> getMasterSubscriptions() async {
    return await _apiClient.getMasterSubscriptons();
  }

  @override
  Future<List<SubscriptionModel>> getSlaveSubscriptions() async {
    return await _apiClient.getSlaveSubscriptons();
  }
}
