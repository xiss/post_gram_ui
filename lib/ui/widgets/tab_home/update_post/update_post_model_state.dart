import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';

class UpdatePostModelState {
  final String? body;
  final String? header;
  final bool isLoading;
  final Exception? exeption;
  final String? postId;
  final List<String> newContent;
  final List<AttachmentModel> contentToDelete;
  final List<AttachmentModel> currentContent;

  UpdatePostModelState({
    required this.header,
    required this.newContent,
    required this.contentToDelete,
    required this.currentContent,
    required this.postId,
    required this.body,
    required this.exeption,
    this.isLoading = false,
  });

  UpdatePostModelState copyWith({
    String? body,
    String? header,
    bool? isLoading,
    Exception? exeption,
    String? postId,
    List<String>? newContent,
    List<AttachmentModel>? contentToDelete,
    List<AttachmentModel>? currentContent,
  }) {
    return UpdatePostModelState(
      body: body ?? this.body,
      header: header ?? this.header,
      isLoading: isLoading ?? this.isLoading,
      exeption: exeption ?? this.exeption,
      postId: postId ?? this.postId,
      newContent: newContent ?? this.newContent,
      contentToDelete: contentToDelete ?? this.contentToDelete,
      currentContent: currentContent ?? this.currentContent,
    );
  }
}
