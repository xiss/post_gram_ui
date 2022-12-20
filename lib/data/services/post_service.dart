import 'package:dio/dio.dart';
import 'package:post_gram_ui/data/services/database_service.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/attachment/avatar.dart';
import 'package:post_gram_ui/domain/models/attachment/post_content.dart';
import 'package:post_gram_ui/domain/models/post/create_post_model.dart';
import 'package:post_gram_ui/domain/models/post/post.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/user/user.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/dependencies/repository_module.dart';

class PostService {
  final ApiRepositoryBase _apiRepository = RepositoryModule.apiReposytory();
  final DatabaseService _databaseService = DatabaseService();

  Future syncPosts() async {
    List<PostModel> postModels = List.empty();

    try {
      postModels = await _apiRepository.getPosts(10, 0);
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

      await _databaseService.createUpdateRange(authors);
      await _databaseService.createUpdateRange(avatars);
      await _databaseService.createUpdateRange(posts);
      await _databaseService.createUpdateRange(postContents);
    }
  }

  Future<String> createPost(CreatePostModel model) async {
    return await _apiRepository.createPost(model: model);
  }
}
