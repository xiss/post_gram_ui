import 'dart:io';

import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/roots/create_post/create_post_view_model.dart';
import 'package:provider/provider.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreatePostViewModel viewModel = context.watch<CreatePostViewModel>();
    const sizedBoxSpace = SizedBox(height: 24);
    return Scaffold(
      appBar: AppBar(),
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
                  if (viewModel.state.errorText != null)
                    Text(
                      viewModel.state.errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  if (viewModel.state.attachments.isNotEmpty)
                    _getPreviews(viewModel.state.attachments)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPreviews(List<String> imagePaths) {
    List<Widget> list = [];

    for (var i = 0; i < imagePaths.length; i++) {
      list.add(Image(width: 100, image: FileImage(File(imagePaths[i]))));
    }
    GridView gridView = GridView(
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: list);

    return Flexible(
      fit: FlexFit.loose,
      flex: 0,
      child: gridView,
    );
  }

  static Widget create() => ChangeNotifierProvider<CreatePostViewModel>(
        create: (context) => CreatePostViewModel(context: context),
        child: const CreatePostWidget(),
      );
}
