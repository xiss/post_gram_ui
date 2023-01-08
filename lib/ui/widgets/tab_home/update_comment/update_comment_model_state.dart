class UpdateCommentModelState {
  final String? body;
  final bool isLoading;
  final Exception? exeption;
  final String? commentId;

  UpdateCommentModelState({
    this.commentId,
    this.body,
    this.exeption,
    this.isLoading = false,
  });

  UpdateCommentModelState copyWith({
    String? body,
    bool isLoading = false,
    Exception? exeption,
    String? commentId,
  }) {
    return UpdateCommentModelState(
      body: body ?? this.body,
      exeption: exeption ?? this.exeption,
      commentId: commentId ?? this.commentId,
      isLoading: isLoading,
    );
  }
}
