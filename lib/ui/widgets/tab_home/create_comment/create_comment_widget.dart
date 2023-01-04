import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/create_comment/create_comment_view_model.dart';
import 'package:provider/provider.dart';

class CreateCommentWidget extends StatelessWidget {
  //TODO Почему он  StatelessWidget если сосояние есть?
  const CreateCommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateCommentViewModel viewModel = context.watch<CreateCommentViewModel>();
    const sizedBoxSpace = SizedBox(height: 24);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add comment"),
      ),
      body: SafeArea(
        child: Flexible(
          fit: FlexFit.loose,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //quoted text
                  viewModel.quoteController.text.isNotEmpty
                      ? Column(
                          children: [
                            TextField(
                              controller: viewModel.quoteController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Quoted text",
                              ),
                              readOnly: true,
                              focusNode: viewModel.quoteFocusNode,
                            ),
                            sizedBoxSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(viewModel.state.quote != null
                                    ? viewModel.state.quote!
                                    : ""),
                              ],
                            ),
                            sizedBoxSpace,
                          ],
                        )
                      : const SizedBox.shrink(),

                  //comment body
                  TextField(
                    controller: viewModel.bodyController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Comment*",
                    ),
                  ),
                  sizedBoxSpace,

                  //add comment
                  ElevatedButton(
                    onPressed:
                        viewModel.checkFields() && !viewModel.state.isLoading
                            ? viewModel.addComment
                            : null,
                    child: const Text("Add comment"),
                  ),
                  sizedBoxSpace,

                  if (viewModel.state.isLoading)
                    const CircularProgressIndicator(),
                  if (viewModel.state.errorText != null)
                    Text(
                      viewModel.state.errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget create(Object? arg) {
    String postId;
    String? quotedCommentId;
    String? quotedText;

    if (arg != null && arg is List && arg.isNotEmpty && arg[0] is String) {
      postId = arg[0];
      if (arg.length == 3 && arg[1] is String && arg[2] is String) {
        quotedCommentId = arg[1];
        quotedText = arg[2];
      }
      return ChangeNotifierProvider<CreateCommentViewModel>(
        create: (context) => CreateCommentViewModel(
          quotedText,
          context: context,
          postId: postId,
          quotedCommentId: quotedCommentId,
        ),
        child: const CreateCommentWidget(),
      );
    }
    throw FormatException("Incorect format: $arg");
  }
}
