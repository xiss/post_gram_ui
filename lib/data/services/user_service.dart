import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/dependencies/repository_module.dart';

class UserService {
  final ApiRepositoryBase _apiRepository = RepositoryModule.apiReposytory();

  Future<List<SubscriptionModel>> getMasterSubscriptions() async {
    return await _apiRepository.getMasterSubscriptions();
  }

  Future<List<SubscriptionModel>> getSlaveSubscriptions() async {
    return await _apiRepository.getSlaveSubscriptions();
  }
}
