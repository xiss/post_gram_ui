import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  // final AuthService _authService = AuthService();
  final AttachmentService _attachmentService = AttachmentService();

  _ViewModel({required this.context}) {
    _asyncInit();
  }

  UserModel? _user;
  UserModel? get user => _user;
  set user(UserModel? val) {
    _user = val;
    notifyListeners();
  }

  void _asyncInit() async {
    user = await SharedPreferencesHelper.getStoredUser();
  }

  // void _logout() async {
  //   await _authService.logout().then((value) => AppNavigator.toLoader());
  // }

  void _profile() {
    AppNavigator.toProfile();
  }
}

class AppMainWidget extends StatelessWidget {
  const AppMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _ViewModel viewModel = context.watch<_ViewModel>();
    //TODO убрать знаки вопроса
    NetworkImage? avatar = viewModel._attachmentService
        .getAttachment(viewModel._user?.avatar?.link);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(4),
            child: CircleAvatar(backgroundImage: avatar),
          ),
          title: Text(viewModel._user?.name == null
              ? "null"
              : viewModel._user!.name.toString()),
          actions: [
            // IconButton(
            //   icon: const Icon(Icons.logout),
            //   onPressed: viewModel._logout,
            // ),
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
