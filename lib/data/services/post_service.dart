import 'dart:io';

import 'package:dio/dio.dart';
import 'package:post_gram_ui/data/repositories/database_repository.dart';
import 'package:post_gram_ui/data/services/converter_d_b.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/attachment/avatar.dart';
import 'package:post_gram_ui/domain/models/attachment/post_content.dart';
import 'package:post_gram_ui/domain/models/comment/comment.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/domain/models/comment/create_comment_model.dart';
import 'package:post_gram_ui/domain/models/comment/update_comment_model.dart';
import 'package:post_gram_ui/domain/models/like/create_like_model.dart';
import 'package:post_gram_ui/domain/models/like/like.dart';
import 'package:post_gram_ui/domain/models/like/like_model.dart';
import 'package:post_gram_ui/domain/models/like/update_like_model.dart';
import 'package:post_gram_ui/domain/models/post/create_post_model.dart';
import 'package:post_gram_ui/domain/models/post/post.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/post/update_post_model.dart';
import 'package:post_gram_ui/domain/models/user/user.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/dependencies/repository_module.dart';

class PostService {
  final ApiRepositoryBase _apiRepository = RepositoryModule.apiReposytory();
  static final DatabaseRepository _database = DatabaseRepository.instance;
  static final ConverterDB _converter = ConverterDB();

  Future syncPosts() async {
    List<PostModel> postModels = [];

    try {
      postModels = await _apiRepository.getPosts(
          100, 0); //TODO Подгрузка постов постепенно
      if (postModels.isNotEmpty) {
        List<Post> posts = postModels.map((e) => Post.fromModel(e)).toList();
        Set<User> authors =
            postModels.map((e) => User.fromModel(e.author)).toSet();
        Set<Avatar> avatars = postModels
            .where((element) => element.author.avatar != null)
            .map((element) =>
                Avatar.fromModel(element.author.avatar!, element.author.id))
            .toSet();
        List<PostContent> postContents = postModels
            .expand((element) => element.content
                .map((e) => PostContent.fromModel(e, element.id)))
            .toList();

        List<Like> likes = postModels
            .where((element) => element.likeByUser != null)
            .map((e) => Like.fromModel(e.likeByUser!))
            .toList();

        await _database.createUpdateRange(authors);
        await _database.createUpdateRange(avatars);
        await _database.createUpdateRange(posts);
        await _database.createUpdateRange(postContents);
        await _database.createUpdateRange(likes);
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        return;
      }

      throw const InnerPostGramException(
          "Inner Exception during synchronization posts");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during synchronization posts");
    }
  }

  Future syncCommentsForPost(String postId) async {
    List<CommentModel> commentModels = [];
    try {
      commentModels = await _apiRepository.getCommentsForPost(postId);

      if (commentModels.isNotEmpty) {
        List<Comment> comments =
            commentModels.map((e) => Comment.fromModel(e)).toList();

        List<Like> likes = commentModels
            .where((element) => element.likeByUser != null)
            .map((e) => Like.fromModel(e.likeByUser!))
            .toList();

        Set<User> authors =
            commentModels.map((e) => User.fromModel(e.author)).toSet();
        Set<Avatar> avatars = commentModels
            .where((element) => element.author.avatar != null)
            .map((element) =>
                Avatar.fromModel(element.author.avatar!, element.author.id))
            .toSet();

        await _database.createUpdateRange(authors);
        await _database.createUpdateRange(avatars);
        await _database.createUpdateRange(comments);
        await _database.createUpdateRange(likes);
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        return;
      }

      throw const InnerPostGramException(
          "Inner Exception during synchronization comments");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during synchronization comments");
    }
  }

  Future syncComment(String commentId) async {
    try {
      CommentModel commentModel = await _apiRepository.getComment(commentId);

      Comment comment = Comment.fromModel(commentModel);
      await _database.createUpdate(comment);

      User user = User.fromModel(commentModel.author);
      await _database.createUpdate(user);

      if (commentModel.likeByUser != null) {
        Like like = Like.fromModel(commentModel.likeByUser!);
        await _database.createUpdate(like);
      }

      if (commentModel.author.avatar != null) {
        Avatar avatar = Avatar.fromModel(commentModel.author.avatar!, user.id);
        await _database.createUpdate(avatar);
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException("Comment not found on server");
      }

      throw const InnerPostGramException(
          "Inner Exception during synchronization comment");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during synchronization comment");
    }
  }

  Future syncPost(String postId) async {
    try {
      PostModel postModel = await _apiRepository.getPost(postId);

      Post post = Post.fromModel(postModel);
      await _database.createUpdate(post);

      User authors = User.fromModel(postModel.author);
      await _database.createUpdate(authors);

      if (postModel.author.avatar != null) {
        Avatar avatar = Avatar.fromModel(postModel.author.avatar!, authors.id);
        await _database.createUpdate(avatar);
      }

      List<PostContent> postContents = postModel.content
          .map((e) => PostContent.fromModel(e, post.id))
          .toList();
      await _database.createUpdateRange(postContents);

      if (postModel.likeByUser != null) {
        Like like = Like.fromModel(postModel.likeByUser!);
        await _database.createUpdate(like);
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException("Post not found on server");
      }

      throw const InnerPostGramException(
          "Inner Exception during synchronization post");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during synchronization post");
    }
  }

  Future<String> createPost(CreatePostModel model) async {
    try {
      return await _apiRepository.createPost(model: model);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      throw const InnerPostGramException(
          "Inner Exception during creation post");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during creation post");
    }
  }

  Future<String> createComment(CreateCommentModel model) async {
    try {
      return await _apiRepository.createComment(model: model);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      throw const InnerPostGramException(
          "Inner Exception during creation comment");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during creation comment");
    }
  }

  Future<String> createLike(CreateLikeModel model) async {
    try {
      return await _apiRepository.createLike(model: model);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      throw const InnerPostGramException(
          "Inner Exception during creation like");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during creation like");
    }
  }

  Future<CommentModel> updateComment(UpdateCommentModel model) async {
    try {
      CommentModel commentModel =
          await _apiRepository.updateComment(model: model);
      await _database.createUpdate(Comment.fromModel(commentModel));
      return commentModel;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException("Comment not found on server");
      }

      throw const InnerPostGramException(
          "Inner Exception during updating comment");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during updating comment");
    }
  }

  Future<LikeModel> updateLike(UpdateLikeModel model) async {
    try {
      LikeModel likeModel = await _apiRepository.updateLike(model: model);
      await _database.createUpdate(Like.fromModel(likeModel));
      return likeModel;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException("Like not found on server");
      }

      throw const InnerPostGramException(
          "Inner Exception during updating like");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during updating like");
    }
  }

  Future<PostModel> updatePost(UpdatePostModel model) async {
    try {
      PostModel postModel = await _apiRepository.updatePost(model: model);
      Post post = Post.fromModel(postModel);
      List<PostContent> postContents =
          postModel.content.map((e) => PostContent.fromModel(e, e.id)).toList();
      await _database.createUpdate(post);
      await _database.deleteRange<PostContent>({'postId': model.id});
      await _database.createUpdateRange(postContents);
      return postModel;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException("Post not found on server");
      }

      throw const InnerPostGramException(
          "Inner Exception during updating post");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during updating post");
    }
  }

  Future<String> deleteComment(String commentId) async {
    try {
      String deletedCommentId =
          await _apiRepository.deleteComment(commentId: commentId);
      await _database.deleteById<Comment>(deletedCommentId);
      return deletedCommentId;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException("Comment not found on server");
      }

      throw const InnerPostGramException(
          "Inner Exception during deleting comment");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during deleting comment");
    }
  }

  Future<String> deletePost(String postId) async {
    try {
      String deletedPostId = await _apiRepository.deletePost(postId: postId);
      await _database.deleteById<Post>(deletedPostId);
      await _database.deleteRange<PostContent>({'postId': deletedPostId});
      return deletedPostId;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException("Post not found on server");
      }

      throw const InnerPostGramException(
          "Inner Exception during deleting post");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during deleting post");
    }
  }

  Future<PostModel?> getPost(String postId) async {
    PostModel? result;
    Post? post = await _database.get<Post>(postId);

    if (post != null) {
      result = await _converter.postToPostModel(post);
    }
    return result;
  }

  Future<CommentModel?> getComment(String commentId) async {
    CommentModel? result;
    Comment? comment = await _database.get<Comment>(commentId);
    if (comment != null) {
      result = await _converter.commentToCommentModel(comment);
    }
    return result;
  }

  Future<List<PostModel>> getPosts() async {
    List<PostModel> result = <PostModel>[];
    Iterable<Post> posts = await _database.getRange<Post>();

    for (Post post in posts) {
      result.add(await _converter.postToPostModel(post));
    }

    return result;
  }

  Future<List<CommentModel>> getCommentsForPost(String postId) async {
    List<CommentModel> result = [];
    Iterable<Comment> comments =
        await _database.getRange<Comment>(whereMap: {"postId": postId});

    for (Comment comment in comments) {
      result.add(await _converter.commentToCommentModel(comment));
    }

    return result;
  }
}
