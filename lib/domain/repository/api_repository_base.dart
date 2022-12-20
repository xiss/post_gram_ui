import 'dart:io';

import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';
import 'package:post_gram_ui/domain/models/auth/token_response.dart';
import 'package:post_gram_ui/domain/models/post/create_post_model.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_create_model.dart';
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

  Future<List<PostModel>> getPosts(int take, int skip);

  Future<dynamic> registerUser(UserCreateModel model);

  Future<MetadataModel> uploadFile({required File file});

  Future<List<MetadataModel>> uploadFiles({required List<File> files});

  Future addAvatarToUser({required MetadataModel model});

  Future deleteCurrentUserAvatar();

  Future<String> createPost({required CreatePostModel model});
}
