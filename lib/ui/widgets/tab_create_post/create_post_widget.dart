import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/common/error_post_gram_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/image_preview_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_create_post/create_post_view_model.dart';
import 'package:provider/provider.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreatePostViewModel viewModel = context.watch<CreatePostViewModel>();
    const sizedBoxSpace = SizedBox(height: 24);

    if (viewModel.state.exeption != null) {
      return ErrorPostGramWidget(viewModel.state.exeption!);
    }

    return Scaffold(
      body: SafeArea(
        child: Flexible(
          fit: FlexFit.loose,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: viewModel.headerController,
                    enabled: !viewModel.state.isLoading,
                    decoration: const InputDecoration(
                      labelText: "Header*",
                    ),
                  ),
                  sizedBoxSpace,
                  TextFormField(
                    controller: viewModel.bodyController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Body*",
                    ),
                    maxLines: 5,
                  ),
                  sizedBoxSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: viewModel.checkFields() &&
                                !viewModel.state.isLoading
                            ? viewModel.addPost
                            : null,
                        child: const Text("Add post"),
                      ),
                      sizedBoxSpace,
                      ElevatedButton(
                        onPressed: viewModel.addPhoto,
                        child: const Text("Add photo"),
                      ),
                    ],
                  ),
                  if (viewModel.state.isLoading)
                    const CircularProgressIndicator(),
                  if (viewModel.state.attachments.isNotEmpty)
                    ImagePreviewWidget<String>(
                        viewModel.state.attachments, viewModel.deletePhoto)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<CreatePostViewModel>(
        create: (context) => CreatePostViewModel(context: context),
        child: const CreatePostWidget(),
      );
}
