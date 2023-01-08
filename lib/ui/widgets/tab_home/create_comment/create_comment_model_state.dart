class CreateCommentModelState {
  final String? body;
  final bool isLoading;
  final Exception? exeption;
  final String? postId;
  final String? quoteCommentId;
  final String? quoteSource;
  final String? quote;

  CreateCommentModelState({
    this.postId,
    this.quoteCommentId,
    this.quoteSource,
    this.body,
    this.exeption,
    this.quote,
    this.isLoading = false,
  });

  CreateCommentModelState copyWith(
      {String? body,
      bool isLoading = false,
      Exception? exeption,
      String? postId,
      String? quoteCommentId,
      String? quoteSource,
      String? quote}) {
    return CreateCommentModelState(
      body: body ?? this.body,
      exeption: exeption ?? this.exeption,
      postId: postId ?? this.postId,
      quoteCommentId: quoteCommentId ?? this.quoteCommentId,
      quoteSource: quoteSource ?? this.quoteSource,
      quote: quote ?? this.quote,
      isLoading: isLoading,
    );
  }
}
