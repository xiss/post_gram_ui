class CreatePostModelState {
  final String? header;
  final String? body;
  final bool isLoading;
  final Exception? exeption;
  List<String> attachments = List.empty();

  CreatePostModelState({
    this.header,
    this.body,
    required this.attachments,
    this.isLoading = false,
    this.exeption,
  });

  CreatePostModelState copyWith({
    String? header,
    String? body,
    List<String>? attachments,
    bool isLoading = false,
    Exception? exeption,
  }) {
    return CreatePostModelState(
      header: header ?? this.header,
      body: body ?? this.body,
      attachments: attachments ?? this.attachments,
      isLoading: isLoading,
      exeption: exeption,
    );
  }
}
