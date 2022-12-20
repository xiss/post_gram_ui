import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    return await _apiRepository.uploadFile(file: file);
  }

  Future<List<MetadataModel>> uploadFiles(List<File> files) async {
    return await _apiRepository.uploadFiles(files: files);
  }

  Future addAvatarToUser(MetadataModel model) async {
    return await _apiRepository.addAvatarToUser(model: model);
  }

  Future deleteCurrentUserAvatar() async {
    return await _apiRepository.deleteCurrentUserAvatar();
  }
}
