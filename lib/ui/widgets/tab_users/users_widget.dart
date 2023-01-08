import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/common/users/users_view_widget.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UsersViewWidget.createSlaveSubs(),
      ),
    );
  }
}
