import 'dart:io';

import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/post_service.dart';
import 'package:post_gram_ui/domain/models/attachment/metadata_model.dart';
import 'package:post_gram_ui/domain/models/post/create_post_model.dart';
import 'package:post_gram_ui/ui/widgets/common/camera_widget.dart';
import 'package:post_gram_ui/ui/widgets/roots/app/app_view_model.dart';
import 'package:post_gram_ui/ui/widgets/tab_create_post/create_post_model_state.dart';
import 'package:provider/provider.dart';

class CreatePostViewModel extends ChangeNotifier {
  BuildContext context;
  final PostService _postService = PostService();
  final AttachmentService _attachmentService = AttachmentService();
  AppViewModel? _appViewModel;

  TextEditingController bodyController = TextEditingController();
  TextEditingController headerController = TextEditingController();

  CreatePostViewModel({required this.context}) {
    bodyController.addListener(() {
      state = state.copyWith(body: bodyController.text);
    });
    headerController.addListener(() {
      state = state.copyWith(header: headerController.text);
    });

    _appViewModel = context.read<AppViewModel>();
  }

  CreatePostModelState _state = CreatePostModelState(attachments: []);
  CreatePostModelState get state {
    return _state;
  }

  set state(CreatePostModelState value) {
    _state = value;
    notifyListeners();
  }

  bool checkFields() {
    return (state.body?.isNotEmpty ?? false) &&
        (state.header?.isNotEmpty ?? false) &&
        (state.attachments.isNotEmpty);
  }

  Future addPost() async {
    String? body = state.body;
    String? header = state.header;
    if (body != null && header != null) {
      List<File> files = [];
      for (var element in state.attachments) {
        files.add(File(element));
      }

      try {
        List<MetadataModel> attachments =
            await _attachmentService.uploadFiles(files);
        CreatePostModel model = CreatePostModel(
            header: header, body: body, attachments: attachments);
        await _postService.createPost(model);
      } on Exception catch (e) {
        state = state.copyWith(exeption: e);
      }
      _clearForm();
    }
    _appViewModel?.notifyListeners();
    notifyListeners();
  }

  Future addPhoto() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (newContext) => CameraWidget(
          title: "Take a photos",
          onFile: (file) {
            state.attachments.add(file.path);
            notifyListeners();
          },
        ),
      ),
    );
  }

  void deletePhoto(String photoPath) {
    state.attachments.remove(photoPath);
    notifyListeners();
  }

  void _clearForm() {
    state = CreatePostModelState(attachments: []);
    headerController.text = "";
    bodyController.text = "";
  }
}
