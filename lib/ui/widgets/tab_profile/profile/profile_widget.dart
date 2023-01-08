import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/common/error_post_gram_widget.dart';
import 'package:post_gram_ui/ui/widgets/common/users/users_view_widget.dart';
import 'package:post_gram_ui/ui/widgets/tab_profile/profile/profile_view_model.dart';
import 'package:post_gram_ui/ui/widgets/common/styles/font_styles.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel viewModel = context.watch<ProfileViewModel>();
    const sizedBoxSpace = SizedBox(height: 24);

    if (viewModel.exeption != null) {
      return ErrorPostGramWidget(viewModel.exeption!);
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sizedBoxSpace,
          Table(
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
          sizedBoxSpace,
          Text(
            "Requests to subscribe",
            style: FontStyles.getHeaderTextStyle(),
          ),
          UsersViewWidget.createMasterSubs(),
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
