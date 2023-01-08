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

class PostViewModel extends ChangeNotifier {
  final AttachmentService _attachmentService = AttachmentService();
  final UserService _userService = UserService();
  final PostService _postService = PostService();
  final BuildContext context;
  final String _postId;
  final bool _generateLinkToDetailedView;
  int pager = 0;
  bool _disposed = false;

  PostViewModel(this._postId, this._generateLinkToDetailedView,
      {required this.context}) {
    _acyncInit();
  }

  Exception? _exeption;
  Exception? get exeption => _exeption;
  set exeption(Exception? exeption) {
    _exeption = exeption;
    notifyListeners();
  }

  List<Future<NetworkImage>> _content = [];
  List<Future<NetworkImage>> get content => _content;
  set content(List<Future<NetworkImage>> content) {
    _content = content;
    notifyListeners();
  }

  Future<NetworkImage?>? _avatar;
  Future<NetworkImage?>? get avatar => _avatar;
  set avatar(Future<NetworkImage?>? avatar) {
    _avatar = avatar;
    notifyListeners();
  }

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  set currentUser(UserModel? currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

  PostModel? _post;
  PostModel? get post => _post;
  set post(PostModel? post) {
    _post = post;
    notifyListeners();
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

  Future _acyncInit() async {
    currentUser = await _userService.getCurrentUser();
    post = await _postService.getPost(_postId);
    if (post != null) {
      List<Future<NetworkImage>> result = [];
      for (var element in post!.content) {
        result.add(
          _attachmentService.getAttachment(element.link),
        );
      }
      content = result;
    }

    avatar = _attachmentService.getAttachment(post?.author.avatar?.link);
  }

  void onPageChanged(int pageIndex) {
    pager = pageIndex;
    notifyListeners();
  }

  void toPostDetail() {
    if (_generateLinkToDetailedView) {
      Navigator.of(context)
          .pushNamed(TabNavigatorRoutes.postDetails, arguments: _postId);
    }
  }

  Future updatePost() async {
    Navigator.of(context)
        .pushNamed(TabNavigatorRoutes.updatePost, arguments: _postId);
  }

  Future createUpdateLike(bool isLike) async {
    LikeModel? like = post?.likeByUser;
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
          entityId: _postId,
          entityType: LikableEntities.post,
        );
        await _postService.createLike(model);
      }
      await _postService.syncPost(_postId);
    } on Exception catch (e) {
      exeption = e;
    }

    post = await _postService.getPost(_postId);
  }
}
