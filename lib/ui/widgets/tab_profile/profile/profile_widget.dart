import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/tab_profile/profile/profile_view_model.dart';
import 'package:post_gram_ui/ui/widgets/common/styles/font_styles.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel viewModel = context.watch<ProfileViewModel>();

//TODO
    if (viewModel.error != null) {
      //viewModel.error = null;
      return AlertDialog(
        title: const Text('Message'),
        content: const Text('Your file is saved.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // dismisses only the dialog and returns nothing
            },
            child: const Text('OK'),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: viewModel.logout,
          ),
        ],
      ),
      body: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.fill,
        children: [
          TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: viewModel.changePhoto,
                    //avatar
                    child: CircleAvatar(
                      backgroundImage: viewModel.avatar,
                      radius: 80,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //viewModel.error != null? AlertDialog():null,
                  //text details
                  Text(
                    viewModel.fullName,
                    style: FontStyles.getHeaderTextStyle(),
                  ),
                  Text(
                    viewModel.eMail,
                    style: FontStyles.getHeaderTextStyle(),
                  ),
                  Text(
                    viewModel.birthDate,
                    style: FontStyles.getHeaderTextStyle(),
                  ),
                  Text(
                    viewModel.followers,
                    style: FontStyles.getHeaderTextStyle(),
                  ),
                  Text(
                    viewModel.subscriptions,
                    style: FontStyles.getHeaderTextStyle(),
                  ),
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
