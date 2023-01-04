import 'package:post_gram_ui/data/repositories/api_repository.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/dependencies/api_module.dart';

class RepositoryModule {
  static ApiRepositoryBase? _apiRepositoryBase;

  static ApiRepositoryBase apiReposytory() {
    return _apiRepositoryBase ??
        ApiRepository(ApiModule.auth(), ApiModule.api());
  }
}
