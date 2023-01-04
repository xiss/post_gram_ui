import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/enums/likable_entities.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/domain/models/like/create_like_model.dart';
import 'package:post_gram_ui/domain/models/like/like_model.dart';
import 'package:post_gram_ui/domain/models/like/update_like_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/ui/navigation/tab_navigator_routes.dart';

class CommentViewViewModel extends ChangeNotifier {
  final BuildContext context;
  final AttachmentService _attachmentService = AttachmentService();
  final UserService _userService = UserService();
  final PostService _postService = PostService();
  final CommentModel comment;
  final CommentModel? quotedComment;
  String quote = "";
  Future<NetworkImage?>? avatar;
  UserModel? currentUser;

  CommentViewViewModel(
    this.comment, {
    required this.context,
    this.quotedComment,
  }) {
    avatar = _attachmentService.getAttachment(comment.author.avatar?.link);
    if (quotedComment != null) {
      quote =
          "${quotedComment?.author.nickname} have said: \"${comment.quotedText}\"";
    } else if (comment.quotedText != null) {
      quote = "Comment has been deleted, quote: \"${comment.quotedText}\"";
    }

    asyncInit();
  }

  Future asyncInit() async {
    currentUser = await _userService.getCurrentUser();
    notifyListeners();
  }

  Future createComment() async {
    await Navigator.of(context).pushNamed(
      TabNavigatorRoutes.createComment,
      arguments: [
        comment.postId,
        comment.id,
        comment.body,
      ],
    );
    notifyListeners();
  }

  Future updateComment() async {
    await Navigator.of(context).pushNamed(
      TabNavigatorRoutes.updateComment,
      arguments: comment,
    );
    notifyListeners();
  }

  Future createUpdateLike(bool isLike) async {
    LikeModel? like = comment.likeByUser;
    if (like != null) {
      UpdateLikeModel model = UpdateLikeModel(
        id: like.id,
        isLike: like.isLike == isLike ? null : isLike,
      );
      await _postService.updateLike(model);
    } else {
      CreateLikeModel model = CreateLikeModel(
        isLike: isLike,
        entityId: comment.id,
        entityType: LikableEntities.comment,
      );
      await _postService.createLike(model);
    }
    notifyListeners();
  }
}
