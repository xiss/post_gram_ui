import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:post_gram_ui/domain/models/auth/token_response.dart';

class TokenStorage {
  static const _securityTokenKey = "security_token";
  static const _refreshTokenKey = "refresh_token";
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<TokenResponseModel?> getStoredToken() async {
    final securityToken = await getSecurityToken();
    final refreshToken = await getRefreshToken();

    if (securityToken != null && refreshToken != null) {
      return TokenResponseModel(
        securityToken: securityToken,
        refreshToken: refreshToken,
      );
    }
    return null;
  }

  static Future setStoredToken(TokenResponseModel? model) async {
    _storage.delete(key: _securityTokenKey);
    _storage.delete(key: _refreshTokenKey);
    if (model != null) {
      _storage.write(key: _refreshTokenKey, value: model.refreshToken);
      _storage.write(key: _securityTokenKey, value: model.securityToken);
    }
  }

  static Future<String?> getRefreshToken() async =>
      await _storage.read(key: _refreshTokenKey);

  static Future<String?> getSecurityToken() async =>
      await _storage.read(key: _securityTokenKey);
}
