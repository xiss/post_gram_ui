import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/comment/comment_model.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/update_comment/update_comment_view_model.dart';
import 'package:provider/provider.dart';

class UpdateCommentWidget extends StatelessWidget {
  const UpdateCommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpdateCommentViewModel viewModel = context.watch<UpdateCommentViewModel>();
    const sizedBoxSpace = SizedBox(height: 24);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit comment"),
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
                  //comment body
                  TextField(
                    controller: viewModel.bodyController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Comment*",
                    ),
                  ),
                  sizedBoxSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Save
                      ElevatedButton(
                        onPressed: viewModel.checkFields() &&
                                !viewModel.state.isLoading
                            ? viewModel.updateComment
                            : null,
                        child: const Text("Save changes"),
                      ),
                      //delete comment
                      ElevatedButton(
                        onPressed: viewModel.deleteComment,
                        child: const Text(
                          "Delete comment",
                        ),
                      ),
                    ],
                  ),
                  //update comment

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
    CommentModel comment;

    if (arg != null && arg is CommentModel) {
      comment = arg;

      return ChangeNotifierProvider<UpdateCommentViewModel>(
        create: (context) => UpdateCommentViewModel(
          context: context,
          comment: comment,
        ),
        child: const UpdateCommentWidget(),
      );
    }
    throw FormatException("Incorect format: $arg");
  }
}
