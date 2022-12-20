import 'dart:io';

import 'package:post_gram_ui/data/clients/api_client.dart';
import 'package:post_gram_ui/data/clients/auth_client.dart';
import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';
import 'package:post_gram_ui/domain/models/auth/refresh_token_request_model.dart';
import 'package:post_gram_ui/domain/models/auth/token_request_model.dart';
import 'package:post_gram_ui/domain/models/auth/token_response.dart';
import 'package:post_gram_ui/domain/models/post/create_post_model.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_create_model.dart';
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

//TODO выбирать посты по дате
  @override
  Future<List<PostModel>> getPosts(int take, int skip) async {
    return await _apiClient.getPosts(take, skip);
  }

  @override
  Future<dynamic> registerUser(UserCreateModel model) async {
    return await _authClient.registerUser(model);
  }

  @override
  Future<MetadataModel> uploadFile({required File file}) async {
    return await _apiClient.uploadFile(file: file);
  }

  @override
  Future<List<MetadataModel>> uploadFiles({required List<File> files}) async {
    return await _apiClient.uploadFiles(files: files);
  }

  @override
  Future addAvatarToUser({required MetadataModel model}) async {
    return await _apiClient.addAvatarToUser(model: model);
  }

  @override
  Future deleteCurrentUserAvatar() async {
    return await _apiClient.deleteCurrentUserAvatar();
  }

  @override
  Future<String> createPost({required CreatePostModel model}) async {
    return await _apiClient.createPost(model: model);
  }
}
