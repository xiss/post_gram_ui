import 'package:flutter/cupertino.dart';
import 'package:post_gram_ui/internal/configs/app_config.dart';
import 'package:post_gram_ui/internal/configs/token_storage.dart';

class AttachmentService {
  Future<NetworkImage?> getAttachment(String? url) async {
    NetworkImage? networkImage;

    String? token = await TokenStorage.getSecurityToken();
    if (token != null && url != null) {
      networkImage = NetworkImage(
        baseUrl + url,
        headers: {"Authorization": "Bearer $token"},
      );
    }
    return networkImage;
  }
}
