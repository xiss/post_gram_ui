import 'package:post_gram_ui/data/repositories/database_repository.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/attachment/avatar.dart';
import 'package:post_gram_ui/domain/models/attachment/post_content.dart';
import 'package:post_gram_ui/domain/models/comment/comment.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/domain/models/like/like.dart';
import 'package:post_gram_ui/domain/models/post/post.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/user/user.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';

class ConverterDB {
  static final DatabaseRepository _database = DatabaseRepository.instance;
  Future<PostModel> postToPostModel(Post post) async {
    User? author = await _database.get<User>(post.authorId);
    UserModel authorModel;
    if (author == null) {
      throw NotFoundPostGramException(
          "User ${post.authorId} not found in DB on device");
    }

    Like? like = await _database.get<Like>(post.likeByUserId);

    authorModel = await userToUserModel(author);
    List<PostContent> postContent =
        (await _database.getRange<PostContent>(whereMap: {"postId": post.id}))
            .toList();
    return PostModel.fromEntity(post, authorModel, postContent, like);
  }

  Future<UserModel> userToUserModel(User user) async {
    Avatar? avatar;
    if (user.avatarId != null) {
      avatar = await _database.get<Avatar>(user.avatarId);
    }
    return UserModel.fromEntity(user, avatar);
  }

  Future<CommentModel> commentToCommentModel(Comment comment) async {
    User? author = await _database.get<User>(comment.authorId);
    Like? likeByUser = await _database.get<Like>(comment.likeByUserId);

    if (author == null) {
      throw NotFoundPostGramException(
          "User ${comment.authorId} not found in DB on device");
    }

    UserModel authorModel = await userToUserModel(author);
    return CommentModel.fromEntity(comment, authorModel, likeByUser);
  }
}
