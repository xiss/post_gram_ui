import 'dart:io';

import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';
import 'package:post_gram_ui/domain/models/auth/token_response.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/domain/models/comment/create_comment_model.dart';
import 'package:post_gram_ui/domain/models/comment/update_comment_model.dart';
import 'package:post_gram_ui/domain/models/like/create_like_model.dart';
import 'package:post_gram_ui/domain/models/like/like_model.dart';
import 'package:post_gram_ui/domain/models/like/update_like_model.dart';
import 'package:post_gram_ui/domain/models/post/create_post_model.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/post/update_post_model.dart';
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

  Future<List<CommentModel>> getCommentsForPost(String postId);

  Future<String> createComment({required CreateCommentModel model});

  Future<String> createLike({required CreateLikeModel model});

  Future<CommentModel> updateComment({required UpdateCommentModel model});

  Future<LikeModel> updateLike({required UpdateLikeModel model});

  Future<PostModel> updatePost({required UpdatePostModel model});

  Future<String> deleteComment({required String commentId});

  Future<String> deletePost({required String postId});
}
