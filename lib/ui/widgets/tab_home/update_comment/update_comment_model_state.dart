class UpdateCommentModelState {
  final String? body;
  final bool isLoading;
  final Exception? exeption;
  final String? commentId;
  final String? postId;

  UpdateCommentModelState({
    this.commentId,
    this.body,
    this.exeption,
    this.isLoading = false,
    this.postId,
  });

  UpdateCommentModelState copyWith({
    String? body,
    bool isLoading = false,
    Exception? exeption,
    String? commentId,
    String? postId,
  }) {
    return UpdateCommentModelState(
        body: body ?? this.body,
        exeption: exeption ?? this.exeption,
        commentId: commentId ?? this.commentId,
        isLoading: isLoading,
        postId: postId ?? this.postId);
  }
}
