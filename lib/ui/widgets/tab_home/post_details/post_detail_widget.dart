import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/tab_home/post_details/post_detail_view_model.dart';
import 'package:provider/provider.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PostDetailViewModel viewModel = context.watch();
    return Text(viewModel.postId.toString());
  }

  static dynamic create(Object? arg) {
    String? postId;
    if (arg != null && arg is String) {
      postId = arg;
    }

    return ChangeNotifierProvider<PostDetailViewModel>(
      create: (BuildContext context) =>
          PostDetailViewModel(context: context, postId: postId),
      child: const PostDetailWidget(),
    );
  }
}
