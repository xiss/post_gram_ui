import 'package:dio/dio.dart';
import 'package:post_gram_ui/domain/models/auth/refresh_token_request_model.dart';
import 'package:post_gram_ui/domain/models/auth/token_request_model.dart';
import 'package:post_gram_ui/domain/models/auth/token_response.dart';
import 'package:retrofit/http.dart';
part 'auth_client.g.dart';

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String? baseUrl}) = _AuthClient;

  @POST("/api/Auth/Token")
  Future<TokenResponseModel?> getToken(@Body() TokenRequestModel body);

  @POST("/api/Auth/RefreshToken")
  Future<TokenResponseModel?> getTokenByRefreshToken(
      @Body() RefreshTokenRequestModel refreshToken);
}
