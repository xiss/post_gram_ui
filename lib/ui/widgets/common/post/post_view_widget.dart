import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/widgets/common/author_header_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/error_post_gram_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/page_indicator_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/post/post_view_model.dart';
import 'package:post_gram_ui/ui/widgets/common/styles/font_styles.dart';
import 'package:provider/provider.dart';

class PostViewWidget extends StatelessWidget {
  const PostViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PostViewModel viewModel = context.watch<PostViewModel>();
    PostModel? post = viewModel.post;
    Widget result;
    if (viewModel.exeption != null) {
      return ErrorPostGramWidget(viewModel.exeption!);
    }
    if (post != null) {
      result = GestureDetector(
        onTap: viewModel.toPostDetail,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          height: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthorHeaderWidget(
                avatar: viewModel.avatar,
                name: post.author.nickname,
                created: post.created,
                edited: post.edited,
              ),
              //header
              Text(
                post.header,
                style: FontStyles.getHeaderTextStyle(),
              ),
              //body
              Text(
                post.body,
                style: FontStyles.getMainTextStyle(),
              ),
              //postContent
              Expanded(
                child: PageView.builder(
                  onPageChanged: ((value) => viewModel.onPageChanged(value)),
                  itemCount: viewModel.content.length,
                  itemBuilder: (_, pageIndex) => viewModel.content.isNotEmpty
                      ? FutureBuilder(
                          future: viewModel.content[pageIndex],
                          builder: (_, snapshot) {
                            NetworkImage? postContent = snapshot.data;

                            if (snapshot.hasData && postContent != null) {
                              return Image(
                                image: postContent,
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              PageIndicatorWidget(
                count: viewModel.content.length,
                current: viewModel.pager,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //comments
                  TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.comment),
                    label: Text(post.commentCount.toString()),
                  ),
                  // edit button
                  TextButton.icon(
                    onPressed: post.author.id == viewModel.currentUser?.id
                        ? viewModel.updatePost
                        : null,
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                  ),
                  //likes
                  TextButton.icon(
                    onPressed: (() => viewModel.createUpdateLike(true)),
                    icon: Icon(
                        color:
                            post.likeByUser?.isLike == true ? Colors.red : null,
                        Icons.thumb_up),
                    label: Text(post.likeCount.toString()),
                  ),
                  //dislikes
                  TextButton.icon(
                    onPressed: (() => viewModel.createUpdateLike(false)),
                    icon: Icon(
                        color: post.likeByUser?.isLike == false
                            ? Colors.red
                            : null,
                        Icons.thumb_down),
                    label: Text(post.dislikeCount.toString()),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    } else {
      result = const Center(
        child: CircularProgressIndicator(),
      );
    }
    return result;
  }

  static dynamic create(
    String postId,
    bool inDetailedView,
  ) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PostViewModel(
        context: context,
        inDetailedView: inDetailedView,
        postId: postId,
      ),
      child: const PostViewWidget(),
    );
  }
}
