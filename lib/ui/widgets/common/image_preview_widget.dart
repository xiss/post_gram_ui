import 'dart:io';

import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';

class ImagePreviewWidget<T> extends StatelessWidget {
  final List<T> _images;
  final Function _delete;
  final AttachmentService _attachmentService = AttachmentService();

  ImagePreviewWidget(List<T> imagePaths, Function delete, {super.key})
      : _delete = delete,
        _images = imagePaths;

  Widget _getImage(int index) {
    Widget result = const SizedBox.shrink();
    if (_images[index] is String) {
      result = Image(
          image: FileImage(
        File(_images[index] as String),
      ));
    }
    if (_images[index] is AttachmentModel) {
      result = FutureBuilder(
        future: _attachmentService
            .getAttachment((_images[index] as AttachmentModel).link),
        builder: (_, snapshot) {
          NetworkImage? image = snapshot.data;

          if (snapshot.hasData && image != null) {
            return Image(
              image: image,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    for (var i = 0; i < _images.length; i++) {
      list.add(
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: _getImage(i),
              ),
              TextButton.icon(
                onPressed: (() => _delete(_images[i])),
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
              ),
            ],
          ),
        ),
      );
    }
    return Flexible(
      fit: FlexFit.tight,
      flex: 0,
      child: GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.5,
        ),
        children: list,
      ),
    );
  }
}
