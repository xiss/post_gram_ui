class CreateCommentViewModelState {
  final String? body;
  final bool isLoading;
  final String? errorText;
  final String? postId;
  final String? quoteCommentId;
  final String? quoteSource;
  final String? quote;

  CreateCommentViewModelState({
    this.postId,
    this.quoteCommentId,
    this.quoteSource,
    this.body,
    this.errorText,
    this.quote,
    this.isLoading = false,
  });

  CreateCommentViewModelState copyWith(
      {String? body,
      bool isLoading = false,
      String? errorText,
      String? postId,
      String? quoteCommentId,
      String? quoteSource,
      String? quote}) {
    return CreateCommentViewModelState(
      body: body ?? this.body,
      errorText: errorText ?? this.errorText,
      postId: postId ?? this.postId,
      quoteCommentId: quoteCommentId ?? this.quoteCommentId,
      quoteSource: quoteSource ?? this.quoteSource,
      quote: quote ?? this.quote,
      isLoading: isLoading,
    );
  }
}
