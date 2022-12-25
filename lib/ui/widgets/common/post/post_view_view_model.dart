import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/navigation/tab_navigator_routes.dart';

class PostViewViewModel extends ChangeNotifier {
  BuildContext context;
  int pager = 0;
  Future<NetworkImage?>? avatar;
  final List<Future<NetworkImage>> content = [];
  final AttachmentService _attachmentService = AttachmentService();

  final PostModel post;
  PostViewViewModel(this.post, {required this.context}) {
    for (var element in post.content) {
      content.add(
        _attachmentService.getAttachment(element.link),
      );
    }

    avatar = _attachmentService.getAttachment(post.author.avatar?.link);
  }

  void onPageChanged(int pageIndex) {
    pager = pageIndex;
    notifyListeners();
  }

  void toPostDetail(String postId) {
    Navigator.of(context)
        .pushNamed(TabNavigatorRoutes.postDetails, arguments: postId);
  }
}
