import 'dart:io';

import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/domain/models/post/update_post_model.dart';
import 'package:post_gram_ui/ui/widgets/common/camera_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/update_post/update_post_model_state.dart';

class UpdatePostViewModel extends ChangeNotifier {
  BuildContext context;
  final PostService _postService = PostService();
  final String _postId;
  final AttachmentService _attachmentService = AttachmentService();

  TextEditingController bodyController = TextEditingController();
  TextEditingController headerController = TextEditingController();

  UpdatePostViewModel({
    required String postId,
    required this.context,
  }) : _postId = postId {
    bodyController.addListener(() {
      state = state?.copyWith(body: bodyController.text);
    });
    headerController.addListener(() {
      state = state?.copyWith(header: headerController.text);
    });

    _acyncInit();
  }

  UpdatePostModelState? _state;
  UpdatePostModelState? get state {
    return _state;
  }

  set state(UpdatePostModelState? value) {
    _state = value;
    notifyListeners();
  }

  Future _acyncInit() async {
    PostModel? postModel = await _postService.getPost(_postId);
    if (postModel != null) {
      state = UpdatePostModelState(
        header: postModel.header,
        newContent: [],
        contentToDelete: [],
        currentContent: postModel.content,
        postId: postModel.id,
        body: postModel.body,
        exeption: null,
      );

      bodyController.text = state?.body ?? "";
      headerController.text = state?.header ?? "";
    }
  }

  bool checkFields() {
    UpdatePostModelState? stateL = state;
    bool result = false;
    if (stateL != null) {
      result = (stateL.body?.isNotEmpty ?? false) &&
          (stateL.header?.isNotEmpty ?? false) &&
          ((stateL.currentContent.length + stateL.newContent.length > 0));
    }
    return result;
  }

  void deleteNewPhoto(String photo) {
    state?.newContent.remove(photo);
    notifyListeners();
  }

  void deletePhoto(AttachmentModel photo) {
    state?.contentToDelete.add(photo);
    state?.currentContent.remove(photo);
    notifyListeners();
  }

  Future updatePost() async {
    UpdatePostModelState? stateL = state;
    if (stateL != null) {
      String? body = stateL.body;
      String? header = stateL.header;

      if (body != null && header != null) {
        List<File> files = [];
        for (var element in stateL.newContent) {
          files.add(File(element));
        }
        List<MetadataModel> attachments =
            await _attachmentService.uploadFiles(files);

        UpdatePostModel model = UpdatePostModel(
          id: _postId,
          updatedHeader: header,
          updatedBody: body,
          newContent: attachments,
          contentToDelete: stateL.contentToDelete,
        );

        try {
          await _postService.updatePost(model);
          await _postService.syncPost(_postId);
        } on Exception catch (e) {
          state = state?.copyWith(exeption: e);
        }
      }
      notifyListeners();
      Navigator.of(context).pop();
    }
  }

  Future addPhoto() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (newContext) => CameraWidget(
          title: "Take a photos",
          onFile: (file) {
            state?.newContent.add(file.path);
            notifyListeners();
          },
        ),
      ),
    );
  }

  Future deletePost() async {
    _postService.deletePost(_postId);
    notifyListeners();
    Navigator.of(context).pop();
  }
}
