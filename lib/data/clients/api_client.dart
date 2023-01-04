import 'dart:io';
import 'package:dio/dio.dart';
import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';
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

  @GET("/api/Post/GetPosts")
  Future<List<PostModel>> getPosts(
      @Query("take") int take, @Query("skip") int skip);

  @GET("/api/Post/GetCommentsForPost")
  Future<List<CommentModel>> getCommentsForPost(@Query("postId") String postId);

  @POST("/api/Attachment/UploadFile")
  Future<MetadataModel> uploadFile({@Part(value: "file") required File file});

  @POST("/api/Attachment/UploadFiles")
  Future<List<MetadataModel>> uploadFiles(
      {@Part(value: "files") required List<File> files});

  @POST("/api/User/AddAvatarToUser")
  Future addAvatarToUser({@Body() required MetadataModel model});

  @DELETE("/api/User/DeleteCurrentUserAvatar")
  Future deleteCurrentUserAvatar();

  @POST("/api/Post/CreatePost")
  Future<String> createPost({@Body() required CreatePostModel model});

  @POST("/api/Post/CreateLike")
  Future<String> createLike({@Body() required CreateLikeModel model});

  @POST("/api/Post/CreateComment")
  Future<String> createComment({@Body() required CreateCommentModel model});

  @PUT("/api/Post/UpdateComment")
  Future<CommentModel> updateComment(
      {@Body() required UpdateCommentModel model});

  @PUT("/api/Post/UpdateLike")
  Future<LikeModel> updateLike({@Body() required UpdateLikeModel model});

  @PUT("/api/Post/UpdatePost")
  Future<PostModel> updatePost({@Body() required UpdatePostModel model});

  @DELETE("/api/Post/DeleteComment")
  Future<String> deleteComment({@Query("commentId") required String commentId});

  @DELETE("/api/Post/DeletePost")
  Future<String> deletePost({@Query("postId") required String postId});
}
