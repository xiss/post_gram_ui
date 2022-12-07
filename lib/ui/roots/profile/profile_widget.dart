import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/roots/profile/profile_view_model.dart';
import 'package:post_gram_ui/ui/styles/font_styles.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel viewModel = context.watch<ProfileViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: viewModel.logout,
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
                      backgroundImage: viewModel.avatar,
                      radius: 78,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(viewModel.fullName,
                      style: FontStyles.getProfileTextStyle()),
                  Text(viewModel.eMail,
                      style: FontStyles.getProfileTextStyle()),
                  Text(viewModel.birthDate,
                      style: FontStyles.getProfileTextStyle()),
                  Text(viewModel.folowers,
                      style: FontStyles.getProfileTextStyle()),
                  Text(viewModel.subscriptions,
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
      create: (BuildContext context) => ProfileViewModel(context: context),
      child: const ProfileWidget(),
    );
  }
}
