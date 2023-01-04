class UpdateCommentViewModelState {
  final String? body;
  final bool isLoading;
  final String? errorText;
  final String? commentId;

  UpdateCommentViewModelState({
    this.commentId,
    this.body,
    this.errorText,
    this.isLoading = false,
  });

  UpdateCommentViewModelState copyWith({
    String? body,
    bool isLoading = false,
    String? errorText,
    String? commentId,
  }) {
    return UpdateCommentViewModelState(
      body: body ?? this.body,
      errorText: errorText ?? this.errorText,
      commentId: commentId ?? this.commentId,
      isLoading: isLoading,
    );
  }
}
