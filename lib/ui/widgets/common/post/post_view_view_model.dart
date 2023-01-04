import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/enums/likable_entities.dart';
import 'package:post_gram_ui/domain/models/like/create_like_model.dart';
import 'package:post_gram_ui/domain/models/like/like_model.dart';
import 'package:post_gram_ui/domain/models/like/update_like_model.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/ui/navigation/tab_navigator_routes.dart';

class PostViewViewModel extends ChangeNotifier {
  BuildContext context;
  int pager = 0;
  Future<NetworkImage?>? avatar;
  UserModel? currentUser;
  final List<Future<NetworkImage>> content = [];
  final AttachmentService _attachmentService = AttachmentService();
  final UserService _userService = UserService();
  final PostService _postService = PostService();
  final PostModel post;
  final bool _generateLinkToDetailedView;

  PostViewViewModel(this.post, this._generateLinkToDetailedView,
      {required this.context}) {
    for (var element in post.content) {
      content.add(
        _attachmentService.getAttachment(element.link),
      );
    }

    avatar = _attachmentService.getAttachment(post.author.avatar?.link);
  }

  Future acyncInit() async {
    currentUser = await _userService.getCurrentUser();
  }

  void onPageChanged(int pageIndex) {
    pager = pageIndex;
    notifyListeners();
  }

  void toPostDetail(String postId) {
    if (_generateLinkToDetailedView) {
      Navigator.of(context)
          .pushNamed(TabNavigatorRoutes.postDetails, arguments: postId);
    }
  }

  Future createUpdateLike(bool isLike) async {
    LikeModel? like = post.likeByUser;
    if (like != null) {
      UpdateLikeModel model = UpdateLikeModel(
        id: like.id,
        isLike: like.isLike == isLike ? null : isLike,
      );
      await _postService.updateLike(model);
    } else {
      CreateLikeModel model = CreateLikeModel(
        isLike: isLike,
        entityId: post.id,
        entityType: LikableEntities.post,
      );
      await _postService.createLike(model);
    }
    notifyListeners();
  }
}
