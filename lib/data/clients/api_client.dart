import 'package:dio/dio.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET("/api/User/GetCurrentUser")
  Future<UserModel> getCurrentUser();

  @GET("/api/User/GetMasterSubscriptions")
  Future<List<SubscriptionModel>> getMasterSubscriptons();

  @GET("/api/User/GetSlaveSubscriptions")
  Future<List<SubscriptionModel>> getSlaveSubscriptons();
}
