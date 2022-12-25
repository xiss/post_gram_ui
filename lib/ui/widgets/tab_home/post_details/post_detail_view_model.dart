import 'package:flutter/cupertino.dart';

class PostDetailViewModel extends ChangeNotifier {
  BuildContext context;
  final String? postId;

  PostDetailViewModel({
    required this.context,
    this.postId,
  });
}
