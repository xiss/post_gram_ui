import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  String _name = "";
  NetworkImage? _avater;
  final AttachmentService _attachmentService = AttachmentService();
  _ViewModel({required this.context}) {
    _asyncInit();
  }

  void _asyncInit() async {
    UserModel? user = await SharedPreferencesHelper.getStoredUser();
    if (user != null) {
      _name = "${user.name} (${user.nickname})";

      AttachmentModel? avatarL = user.avatar;
      if (avatarL != null) {
        _avater = await _attachmentService.getAttachment(avatarL.link);
      }
    }
    notifyListeners();
  }

  void _profile() {
    AppNavigator.toProfile();
  }
}

class AppMainWidget extends StatelessWidget {
  const AppMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _ViewModel viewModel = context.watch<_ViewModel>();
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(4),
            child: CircleAvatar(backgroundImage: viewModel._avater),
          ),
          title: Text(viewModel._name),
          actions: [
            IconButton(
                onPressed: viewModel._profile,
                icon: const Icon(Icons.account_box))
          ],
        ),
        body: null);
  }

  static dynamic create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ViewModel(context: context),
      child: const AppMainWidget(),
    );
  }
}
