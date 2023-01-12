import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:post_gram_ui/data/repositories/database_repository.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/converter_d_b.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/attachment/avatar.dart';
import 'package:post_gram_ui/domain/models/subscription/create_subscription_model.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/subscription/update_subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/domain/models/user/user_subscriptions_avatar_model.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/internal/dependencies/repository_module.dart';

class UserService {
  final ApiRepositoryBase _apiRepository = RepositoryModule.apiReposytory();
  static final DatabaseRepository _database = DatabaseRepository.instance;
  static final ConverterDB _converter = ConverterDB();
  static final AttachmentService _attachmentService = AttachmentService();

  Future<UserModel?> getCurrentUser() async {
    return await SharedPreferencesHelper.getStoredUser();
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel> result = [];
    Iterable<User> users = await _database.getRange<User>();
    for (User user in users) {
      result.add(await _converter.userToUserModel(user));
    }

    result.sort((a, b) => a.name.compareTo(b.name));

    return result;
  }

  Future syncUsers() async {
    try {
      List<UserModel> usersModels = await _apiRepository.getUsers();

      Set<User> users = usersModels.map((e) => User.fromModel(e)).toSet();
      Set<Avatar> avatars = usersModels
          .where((element) => element.avatar != null)
          .map((element) => Avatar.fromModel(element.avatar!, element.id))
          .toSet();
      await _database.createUpdateRange(users);
      await _database.createUpdateRange(avatars);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        return;
      }

      throw const InnerPostGramException(
          "Inner Exception during synchronization users");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during synchronization users");
    }
  }

  Future syncCurrentUser() async {
    try {
      UserModel? userModel = await _apiRepository.getCurrentUser();
      if (userModel != null) {
        User user = User.fromModel(userModel);
        if (userModel.avatar != null) {
          Avatar? avatar = Avatar.fromModel(userModel.avatar!, userModel.id);
          await _database.createUpdate(avatar);
        }

        await _database.createUpdate(user);
        await SharedPreferencesHelper.setStoredUser(userModel);
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        return;
      }

      throw const InnerPostGramException(
          "Inner Exception during synchronization user");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during synchronization user");
    }
  }

  Future syncSubscriptions() async {
    await syncSubscriptionsMaster();
    await syncSubscriptionsSlave();
  }

  Future syncSubscriptionsSlave() async {
    List<SubscriptionModel> subscriptionModels;
    try {
      subscriptionModels = await _apiRepository.getSlaveSubscriptions();
      List<Subscription> subscription =
          subscriptionModels.map((e) => Subscription.fromModel(e)).toList();

      await _database.createUpdateRange(subscription);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        return;
      }

      throw const InnerPostGramException(
          "Inner Exception during synchronization subscriptions");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during synchronization subscriptions");
    }
  }

  Future syncSubscriptionsMaster() async {
    List<SubscriptionModel> subscriptionModels;
    try {
      subscriptionModels = await _apiRepository.getMasterSubscriptions();
      List<Subscription> subscription =
          subscriptionModels.map((e) => Subscription.fromModel(e)).toList();

      await _database.createUpdateRange(subscription);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        return;
      }

      throw const InnerPostGramException(
          "Inner Exception during synchronization subscriptions");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during synchronization subscriptions");
    }
  }

  Future<String> createSubscription(CreateSubscriptionModel model) async {
    try {
      return await _apiRepository.createSubscription(model: model);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException(
            "Subscription not found on server");
      }

      throw const InnerPostGramException(
          "Inner Exception during creation subscription");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during creation subscription");
    }
  }

  Future<SubscriptionModel> updateSubscription(
      UpdateSubscriptionModel model) async {
    try {
      SubscriptionModel subscriptionModel =
          await _apiRepository.updateSubscription(model: model);
      await _database.createUpdate(Subscription.fromModel(subscriptionModel));
      return subscriptionModel;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException(
            "Subscription not found on server");
      }

      throw const InnerPostGramException(
          "Inner Exception during updating subscription");
    } catch (e) {
      throw const InnerPostGramException(
          "Inner Exception during updating subscription");
    }
  }

  Future<List<UserSubscriptionsAvatarModel>> getSubscriptionsWithUsers() async {
    List<SubscriptionModel> subscriptionModels = [];
    UserModel? currentUser = await getCurrentUser();
    Iterable<Subscription> subscriptions =
        await _database.getRange<Subscription>();
    for (Subscription subscription in subscriptions) {
      subscriptionModels.add(SubscriptionModel.fromEntity(subscription));
    }
    List<UserModel> users = await getUsers();
    users.remove(currentUser);
    List<UserSubscriptionsAvatarModel> result = [
      for (var user in users)
        UserSubscriptionsAvatarModel(
          user: user,
          avatar: _attachmentService.getAttachment(user.avatar?.link),
          masterSubscription: subscriptionModels.firstWhereOrNull(
              (subscription) =>
                  subscription.slaveId == user.id &&
                  subscription.masterId == currentUser?.id),
          slaveSubscription: subscriptionModels.firstWhereOrNull(
              (subscription) =>
                  subscription.slaveId == currentUser?.id &&
                  subscription.masterId == user.id),
        )
    ];
    result.sort((a, b) => a.user.name.compareTo(b.user.name));

    return result;
  }
}
