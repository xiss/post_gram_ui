import 'package:flutter/material.dart';
import 'package:post_gram_ui/domain/models/post/post_model.dart';
import 'package:post_gram_ui/ui/widgets/common/author_header_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/page_indicator_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/post/post_view_view_model.dart';
import 'package:post_gram_ui/ui/widgets/common/styles/font_styles.dart';
import 'package:provider/provider.dart';

class PostViewWidget extends StatefulWidget {
  const PostViewWidget({super.key});

  @override
  State<PostViewWidget> createState() => _PostViewWidgetState();

  static dynamic create(PostModel post,
      [bool generateLinkToDetailedView = true]) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PostViewViewModel(
        post,
        generateLinkToDetailedView,
        context: context,
      ),
      child: const PostViewWidget(),
    );
  }
}

class _PostViewWidgetState extends State<PostViewWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PostViewViewModel viewModel = context.watch<PostViewViewModel>();

    return GestureDetector(
      onTap: () => viewModel.toPostDetail(viewModel.post.id),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        height: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthorHeaderWidget(
              avatar: viewModel.avatar,
              name: viewModel.post.author.nickname,
              created: viewModel.post.created,
              edited: viewModel.post.edited,
            ),
            //header
            Text(
              viewModel.post.header,
              style: FontStyles.getHeaderTextStyle(),
            ),
            //body
            Text(
              viewModel.post.body,
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
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //comments
                TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.comment),
                  label: Text(viewModel.post.commentCount.toString()),
                ),
                // edit button
                TextButton.icon(
                  onPressed:
                      viewModel.post.author.id == viewModel.currentUser?.id
                          ? null
                          : null, //TODO edit
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                ),
                //likes
                TextButton.icon(
                  onPressed: (() => viewModel.createUpdateLike(true)),
                  icon: Icon(
                      color: viewModel.post.likeByUser?.isLike == true
                          ? Colors.red
                          : null,
                      Icons.thumb_up),
                  label: Text(viewModel.post.likeCount.toString()),
                ),
                //dislikes
                TextButton.icon(
                  onPressed: (() => viewModel.createUpdateLike(false)),
                  icon: Icon(
                      color: viewModel.post.likeByUser?.isLike == false
                          ? Colors.red
                          : null,
                      Icons.thumb_down),
                  label: Text(viewModel.post.dislikeCount.toString()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
