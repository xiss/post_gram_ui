import 'package:dio/dio.dart';
import 'package:post_gram_ui/data/repositories/database_repository.dart';
// import 'package:post_gram_ui/data/services/database_service.dart';
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
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/dependencies/repository_module.dart';

class PostService {
  final ApiRepositoryBase _apiRepository = RepositoryModule.apiReposytory();
  //final DatabaseService _databaseService = DatabaseService();
  static final DatabaseRepository _database = DatabaseRepository.instance;

  Future syncPosts() async {
    List<PostModel> postModels = [];

    try {
      postModels = await _apiRepository.getPosts(100, 0); //TODO
    } on DioError catch (e) {
      if (e.response?.statusCode != 404) {
        throw const InnerPostGramException("Inner Exception");
      }
    } catch (e) {
      throw const InnerPostGramException("Inner Exception");
    }

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
          .expand((element) =>
              element.content.map((e) => PostContent.fromModel(e, element.id)))
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
  }

  Future syncCommentsForPost(String postId) async {
    List<CommentModel> commentModels = [];
    try {
      commentModels = await _apiRepository.getCommentsForPost(postId);
    } on DioError catch (e) {
      if (e.response?.statusCode != 404) {
        throw const InnerPostGramException("Inner Exception");
      }
    } catch (e) {
      throw const InnerPostGramException("Inner Exception");
    }

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
  }

  Future<String> createPost(CreatePostModel model) async {
    return await _apiRepository.createPost(model: model);
  }

  Future<String> createComment(CreateCommentModel model) async {
    return await _apiRepository.createComment(model: model);
  }

  Future<String> createLike(CreateLikeModel model) async {
    return await _apiRepository.createLike(model: model);
  }

  Future<CommentModel> updateComment(UpdateCommentModel model) async {
    CommentModel commentModel =
        await _apiRepository.updateComment(model: model);
    await _database.createUpdate(Comment.fromModel(commentModel));
    return commentModel;
  }

  Future<LikeModel> updateLike(UpdateLikeModel model) async {
    LikeModel likeModel = await _apiRepository.updateLike(model: model);
    await _database.createUpdate(Like.fromModel(likeModel));
    return likeModel;
  }

  Future<PostModel> updatePost(UpdatePostModel model) async {
    PostModel postModel = await _apiRepository.updatePost(model: model);
    Post post = Post.fromModel(postModel);
    List<PostContent> postContents =
        postModel.content.map((e) => PostContent.fromModel(e, e.id)).toList();
    await _database.createUpdate(post);
    await _database.createUpdateRange(postContents);
    return postModel;
  }

  Future<String> deleteComment(String commentId) async {
    String deletedCommentId =
        await _apiRepository.deleteComment(commentId: commentId);
    await _database.deleteById<Comment>(deletedCommentId);
    return deletedCommentId;
  }

  Future<PostModel?> getPost(String postId) async {
    PostModel? result;
    Post? post = await _database.get<Post>(postId);

    if (post != null) {
      result = await _postToPostModel(post);
    }
    return result;
  }

  Future<List<PostModel>> getPosts() async {
    List<PostModel> result = <PostModel>[];
    Iterable<Post> posts = await _database.getRange<Post>();

    for (Post post in posts) {
      result.add(await _postToPostModel(post));
    }

    return result;
  }

  Future<List<CommentModel>> getCommentsForPost(String postId) async {
    List<CommentModel> result = [];
    Iterable<Comment> comments =
        await _database.getRange<Comment>(whereMap: {"postId": postId});

    for (Comment comment in comments) {
      result.add(await _commentToCommentModel(comment));
    }

    return result;
  }

  Future<PostModel> _postToPostModel(Post post) async {
    User? author = await _database.get<User>(post.authorId);
    UserModel authorModel;
    if (author == null) {
      throw NotFoundPostGramException(
          "User ${post.authorId} not fount in DB on device");
    }

    Like? like = await _database.get<Like>(post.likeByUserId);

    authorModel = await _userToUserModel(author);
    List<PostContent> postContent =
        (await _database.getRange<PostContent>(whereMap: {"postId": post.id}))
            .toList();
    return PostModel.fromEntity(post, authorModel, postContent, like);
  }

  Future<UserModel> _userToUserModel(User user) async {
    Avatar? avatar;
    if (user.avatarId != null) {
      avatar = await _database.get<Avatar>(user.avatarId);
    }
    return UserModel.fromEntity(user, avatar);
  }

  Future<CommentModel> _commentToCommentModel(Comment comment) async {
    User? author = await _database.get<User>(comment.authorId);
    Like? likeByUser = await _database.get<Like>(comment.likeByUserId);

    if (author == null) {
      throw NotFoundPostGramException(
          "User ${comment.authorId} not found in DB on device");
    }

    UserModel authorModel = await _userToUserModel(author);
    return CommentModel.fromEntity(comment, authorModel, likeByUser);
  }
}
