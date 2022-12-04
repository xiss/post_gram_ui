import 'package:flutter/cupertino.dart';
import 'package:post_gram_ui/internal/configs/app_config.dart';
import 'package:post_gram_ui/internal/configs/token_storage.dart';

class AttachmentService {
  Map<String, String>? _headers;

  AttachmentService() {
    _asyncInit();
  }

  void _asyncInit() async {
    _headers = {
      "Authorization": "Bearer ${await TokenStorage.getSecurityToken()}"
    };
  }

  NetworkImage? getAttachment(String? url) {
    NetworkImage? networkImage;
    if (_headers != null && url != null) {
      networkImage = NetworkImage(baseUrl + url, headers: _headers);
    }
    return networkImage;
  }
}
