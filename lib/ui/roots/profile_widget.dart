import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/models/attachment/attachment_model.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';
import 'package:post_gram_ui/ui/styles/font_styles.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  final AttachmentService _attachmentService = AttachmentService();
  List<SubscriptionModel> slaveSubscriptions = <SubscriptionModel>[];
  List<SubscriptionModel> masterSubscriptions = <SubscriptionModel>[];

  String _fullName = "";
  String _birthDate = "";
  String _eMail = "";
  String _folowers = "";
  String _subscriptions = "";
  NetworkImage? _avatar;

  _ViewModel({required this.context}) {
    _asyncInit();
  }

  // UserModel? get user => _user;
  // set user(UserModel? val) {
  //   _user = val;
  //   notifyListeners(); //TODO это нужно вообще?
  // }

  void _asyncInit() async {
    // user = await SharedPreferencesHelper.getStoredUser();
    slaveSubscriptions = await _userService.getSlaveSubscriptions();
    masterSubscriptions = await _userService.getMasterSubscriptions();

    _folowers = "Folowers: ${masterSubscriptions.length}";
    _subscriptions = "Subscriptions: ${slaveSubscriptions.length}";

    UserModel? userL = await SharedPreferencesHelper.getStoredUser();
    if (userL != null) {
      _fullName =
          "${userL.name} ${userL.patronymic} ${userL.surname} (${userL.nickname})";
      _birthDate =
          "Birthdate: ${DateFormat('dd.MM.yyyy').format(userL.birthDate.toLocal())}";
      _eMail = "Email: ${userL.email}";
      AttachmentModel? avatarL = userL.avatar;
      if (avatarL != null) {
        _avatar = await _attachmentService.getAttachment(avatarL.link);
      }
    }
    notifyListeners();
  }

  void _logout() async {
    await _authService.logout().then((value) => AppNavigator.toLoader());
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _ViewModel viewModel = context.watch<_ViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: viewModel._logout,
        ),
      ]),
      body: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.fill,
        children: [
          TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 80,
                    child: CircleAvatar(
                      backgroundImage: viewModel._avatar,
                      radius: 78,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(viewModel._fullName,
                      style: FontStyles.getProfileTextStyle()),
                  Text(viewModel._eMail,
                      style: FontStyles.getProfileTextStyle()),
                  Text(viewModel._birthDate,
                      style: FontStyles.getProfileTextStyle()),
                  Text(viewModel._folowers,
                      style: FontStyles.getProfileTextStyle()),
                  Text(viewModel._subscriptions,
                      style: FontStyles.getProfileTextStyle()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static dynamic create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ViewModel(context: context),
      child: const ProfileWidget(),
    );
  }
}
