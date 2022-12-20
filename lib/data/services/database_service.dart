import 'package:post_gram_ui/data/services/database.dart';
import 'package:post_gram_ui/domain/models/attachment/avatar.dart';
import 'package:post_gram_ui/domain/models/attachment/post_content.dart';
import 'package:post_gram_ui/domain/models/db_model_base.dart';
import 'package:post_gram_ui/domain/models/post/post.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/user/user.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';

class DatabaseService {
  static final Database _database = Database.instance;

  Future createUpdateUser(User user) async {
    await _database.createUpdate(user);
  }

  Future createUpdateRange<T extends DbModelBase>(Iterable<T> list) async {
    await _database.createUpdateRange<T>(list);
  }

  Future<List<PostModel>> getPosts() async {
    List<PostModel> result = <PostModel>[];
    Iterable<Post> posts = await _database.getRange<Post>();

    for (Post post in posts) {
      User? author = await _database.get<User>(post.authorId);
      if (author != null && author.avatarId != null) {
        Avatar? avatar = await _database.get<Avatar>(author.avatarId);
        UserModel authorModel = UserModel.fromEntity(author, avatar);
        List<PostContent> postContent = (await _database
                .getRange<PostContent>(whereMap: {"postId": post.id}))
            .toList();
        result.add(PostModel.fromEntity(post, authorModel, postContent));
      }
    }

    return result;
  }

  Future clearDatabase() async {
    await _database.clearDatabase();
  }
}
