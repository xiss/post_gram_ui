import 'package:post_gram_ui/domain/models/auth/token_response.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';

abstract class ApiRepositoryBase {
  Future<TokenResponseModel?> getToken({
    required String login,
    required String password,
  });

  Future<UserModel?> getCurrentUser();

  Future<TokenResponseModel?> getTokenByRefreshToken(String refreshToken);

  Future<List<SubscriptionModel>> getSlaveSubscriptions();

  Future<List<SubscriptionModel>> getMasterSubscriptions();
}
