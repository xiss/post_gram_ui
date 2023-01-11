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
import 'package:post_gram_ui/ui/widgets/common/comments/comments_view_model.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/post_details/post_detail_model.dart';
import 'package:provider/provider.dart';

class CommentViewModel extends ChangeNotifier {
  final BuildContext context;
  final AttachmentService _attachmentService = AttachmentService();
  final UserService _userService = UserService();
  final PostService _postService = PostService();
  final String _comentId;
  CommentModel? comment;
  CommentModel? quotedComment;
  String quote = "";
  Future<NetworkImage?>? avatar;
  UserModel? currentUser;
  bool _disposed = false;
  CommentsViewModel? _commentsViewModel;
  PostDetailModel? _postDetailModel;

  CommentViewModel({
    required String commentId,
    required this.context,
  }) : _comentId = commentId {
    _asyncInit();

    _commentsViewModel = context.read<CommentsViewModel>();
    _postDetailModel = context.read<PostDetailModel>();

    _commentsViewModel?.addListener(() async {
      await _asyncInit();
      notifyListeners();
    });
  }

  Exception? _exeption;
  Exception? get exeption => _exeption;
  set exeption(Exception? exeption) {
    _exeption = exeption;
    notifyListeners();
  }

  Future _asyncInit() async {
    currentUser = await _userService.getCurrentUser();
    comment = await _postService.getComment(_comentId);

    if (comment?.quotedCommentId != null) {
      quotedComment = await _postService.getComment(comment!.quotedCommentId!);
    }

    avatar = _attachmentService.getAttachment(comment?.author.avatar?.link);

    if (quotedComment != null) {
      quote =
          "${quotedComment?.author.nickname} have said: \"${comment?.quotedText}\"";
    } else if (comment?.quotedText != null) {
      quote = "Comment has been deleted, quote: \"${comment?.quotedText}\"";
    }

    notifyListeners();
  }

  Future createComment() async {
    await Navigator.of(context).pushNamed(
      TabNavigatorRoutes.createComment,
      arguments: [
        comment?.postId,
        comment?.id,
        comment?.body,
      ],
    );
    _postDetailModel?.notifyListeners();
  }

  Future updateComment() async {
    var isDeleted = await Navigator.of(context).pushNamed(
      TabNavigatorRoutes.updateComment,
      arguments: comment,
    );

    if ((isDeleted is bool) == true) {
      _postDetailModel?.notifyListeners();
    }

    await _asyncInit();
  }

  Future createUpdateLike(bool isLike) async {
    LikeModel? like = comment?.likeByUser;
    try {
      if (like != null) {
        UpdateLikeModel model = UpdateLikeModel(
          id: like.id,
          isLike: like.isLike == isLike ? null : isLike,
        );
        await _postService.updateLike(model);
      } else {
        CreateLikeModel model = CreateLikeModel(
          isLike: isLike,
          entityId: _comentId,
          entityType: LikableEntities.comment,
        );
        await _postService.createLike(model);
      }
      await _postService.syncComment(_comentId);
    } on Exception catch (e) {
      exeption = e;
    }

    await _asyncInit();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
