import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/ui/widgets/common/error_post_gram_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/image_preview_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/styles/button_styles.dart';
import 'package:post_gram_ui/ui/widgets/common/styles/font_styles.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/update_post/update_post_model_state.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/update_post/update_post_view_model.dart';
import 'package:provider/provider.dart';

class UpdatePostWidget extends StatelessWidget {
  const UpdatePostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpdatePostViewModel viewModel = context.watch<UpdatePostViewModel>();
    const sizedBoxSpace = SizedBox(height: 24);
    UpdatePostModelState? state = viewModel.state;
    Widget result;

    if (viewModel.state?.exeption != null) {
      return ErrorPostGramWidget(viewModel.state!.exeption!);
    }

    if (state != null) {
      result = Scaffold(
        appBar: AppBar(
          title: const Text("Edit post"),
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
                    TextField(
                      controller: viewModel.headerController,
                      enabled: !state.isLoading,
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
                          onPressed: viewModel.checkFields() && !state.isLoading
                              ? viewModel.updatePost
                              : null,
                          child: const Text("Save changes"),
                        ),
                        sizedBoxSpace,
                        ElevatedButton(
                          onPressed: viewModel.addPhoto,
                          child: const Text("Add photo"),
                        ),
                        sizedBoxSpace,
                        ElevatedButton(
                          style: ButtonStyles.getDeleteButtonStyle(),
                          onPressed: viewModel.deletePost,
                          child: const Text("Delete post"),
                        ),
                      ],
                    ),
                    if (state.isLoading) const CircularProgressIndicator(),
                    state.newContent.isNotEmpty
                        ? Column(
                            children: [
                              sizedBoxSpace,
                              Text(
                                "New photos",
                                style: FontStyles.getHeaderTextStyle(),
                              ),
                              ImagePreviewWidget<String>(
                                state.newContent,
                                viewModel.deleteNewPhoto,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    state.currentContent.isNotEmpty
                        ? Column(
                            children: [
                              sizedBoxSpace,
                              Text(
                                "Old photos",
                                style: FontStyles.getHeaderTextStyle(),
                              ),
                              ImagePreviewWidget<AttachmentModel>(
                                state.currentContent,
                                viewModel.deletePhoto,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      result = const Center(child: CircularProgressIndicator());
    }
    return result;
  }

  static Widget create(Object? arg) {
    if (arg != null && arg is String) {
      return ChangeNotifierProvider<UpdatePostViewModel>(
        create: (context) => UpdatePostViewModel(postId: arg, context: context),
        child: const UpdatePostWidget(),
      );
    }
    throw FormatException("Incorect format: $arg");
  }
}
