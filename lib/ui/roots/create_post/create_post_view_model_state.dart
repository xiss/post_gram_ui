class CreatePostViewModelState {
  final String? header;
  final String? body;
  final bool isLoading;
  final String? errorText;
  List<String> attachments = List.empty();

  CreatePostViewModelState({
    this.header,
    this.body,
    required this.attachments,
    this.isLoading = false,
    this.errorText,
  });

  CreatePostViewModelState copyWith({
    String? header,
    String? body,
    List<String>? attachments,
    bool isLoading = false,
    String? errorText,
  }) {
    return CreatePostViewModelState(
      header: header ?? this.header,
      body: body ?? this.body,
      attachments: attachments ?? this.attachments,
      isLoading: isLoading,
      errorText: errorText,
    );
  }
}
