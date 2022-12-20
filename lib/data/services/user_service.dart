import 'package:dio/dio.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/dependencies/repository_module.dart';

class UserService {
  final ApiRepositoryBase _apiRepository = RepositoryModule.apiReposytory();

  Future<List<SubscriptionModel>> getMasterSubscriptions() async {
    try {
      return await _apiRepository.getMasterSubscriptions();
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return List.empty();
      }
      throw const InnerPostGramException("Inner exeption");
    } catch (e) {
      throw const InnerPostGramException("Inner exeption");
    }
  }

  Future<List<SubscriptionModel>> getSlaveSubscriptions() async {
    try {
      return await _apiRepository.getSlaveSubscriptions();
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return List.empty();
      }
      throw const InnerPostGramException("Inner exeption");
    } catch (e) {
      throw const InnerPostGramException("Inner exeption");
    }
  }
}
