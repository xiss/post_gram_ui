import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/attachment_service.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/data/services/user_service.dart';
import 'package:post_gram_ui/domain/models/subscription/subscription_model.dart';
import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:post_gram_ui/internal/configs/shared_preferences_helper.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';
import 'package:post_gram_ui/ui/styles/font_styles.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  final AttachmentService _attachmentService = AttachmentService();
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

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

  void _logout() async {
    await _authService.logout().then((value) => AppNavigator.toLoader());
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _ViewModel viewModel = context.watch<_ViewModel>();
    List<SubscriptionModel> slaveSubscriptions = <SubscriptionModel>[];
    viewModel._userService
        .getSlaveSubscriptions()
        .then((value) => slaveSubscriptions = value);

    List<SubscriptionModel> masterSubscriptions = <SubscriptionModel>[];
    viewModel._userService
        .getMasterSubscriptions()
        .then((value) => masterSubscriptions = value);

    String fullName = "";
    String birthDate = "";
    String eMail = "";
    String folowers = "Folowers: ${masterSubscriptions.length}";
    String subscriptions = "Subscriptions: ${slaveSubscriptions.length}";
    NetworkImage? avatar;

    UserModel? user = viewModel._user;
    if (user != null) {
      fullName =
          "${user.name} ${user.patronymic} ${user.surname} (${user.nickname})";
      birthDate =
          "Birthdate: ${DateFormat('dd.MM.yyyy').format(user.birthDate.toLocal())}";
      eMail = "Email: ${user.email}";

      avatar = viewModel._attachmentService
          .getAttachment(viewModel._user!.avatar!.link);
    }

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
                      backgroundImage: avatar,
                      radius: 78,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(fullName, style: FontStyles.getProfileTextStyle()),
                  Text(eMail, style: FontStyles.getProfileTextStyle()),
                  Text(birthDate, style: FontStyles.getProfileTextStyle()),
                  Text(folowers, style: FontStyles.getProfileTextStyle()),
                  Text(subscriptions, style: FontStyles.getProfileTextStyle()),
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
