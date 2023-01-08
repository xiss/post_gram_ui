import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:post_gram_ui/domain/exceptions.dart';
import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';
import 'package:post_gram_ui/domain/repository/api_repository_base.dart';
import 'package:post_gram_ui/internal/configs/app_config.dart';
import 'package:post_gram_ui/internal/configs/token_storage.dart';
import 'package:post_gram_ui/internal/dependencies/repository_module.dart';

class AttachmentService {
  final ApiRepositoryBase _apiRepository = RepositoryModule.apiReposytory();

  Future<NetworkImage> getAttachment(String? url) async {
    NetworkImage networkImage;

    String? token = await TokenStorage.getSecurityToken();
    networkImage = NetworkImage(
      baseUrl + url.toString(),
      headers: {"Authorization": "Bearer $token"},
    );
    return networkImage;
  }

  Future<MetadataModel> uploadFile(File file) async {
    try {
      return await _apiRepository.uploadFile(file: file);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      throw const InnerPostGramException("Inner Exception");
    } catch (e) {
      throw const InnerPostGramException("Inner Exception");
    }
  }

  Future<List<MetadataModel>> uploadFiles(List<File> files) async {
    try {
      return await _apiRepository.uploadFiles(files: files);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      throw const InnerPostGramException("Inner Exception");
    } catch (e) {
      throw const InnerPostGramException("Inner Exception");
    }
  }

  Future addAvatarToUser(MetadataModel model) async {
    try {
      return await _apiRepository.addAvatarToUser(model: model);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        throw const NotFoundPostGramException("User not found");
      }

      throw const InnerPostGramException("Inner Exception");
    } catch (e) {
      throw const InnerPostGramException("Inner Exception");
    }
  }

  Future deleteCurrentUserAvatar() async {
    try {
      return await _apiRepository.deleteCurrentUserAvatar();
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const NoNetworkPostGramException();
      }

      if (e.response?.statusCode == 404) {
        return;
      }

      throw const InnerPostGramException("Inner Exception");
    } catch (e) {
      throw const InnerPostGramException("Inner Exception");
    }
  }
}
