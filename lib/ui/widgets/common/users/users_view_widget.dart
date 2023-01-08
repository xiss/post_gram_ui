import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/common/styles/font_styles.dart';
import 'package:post_gram_ui/ui/widgets/common/users/users_view_model.dart';
import 'package:provider/provider.dart';

class UsersViewWidget extends StatelessWidget {
  const UsersViewWidget({
    super.key,
  });

  static dynamic createSlaveSubs() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UsersViewModel(
        masterSubs: false,
        slaveSubs: true,
        context: context,
      ),
      child: const UsersViewWidget(),
    );
  }

  static dynamic createMasterSubs() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UsersViewModel(
        masterSubs: true,
        slaveSubs: false,
        context: context,
      ),
      child: const UsersViewWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    UsersViewModel viewModel = context.watch<UsersViewModel>();
    Size size = MediaQuery.of(context).size;
    double widthName = size.width - 155;
    if (viewModel.users.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //avatar
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: FutureBuilder(
                          future: viewModel.users[index].avatar,
                          builder: (_, snapshot) {
                            return CircleAvatar(foregroundImage: snapshot.data);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: widthName,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //author nickname
                                Text(
                                  viewModel.users[index].user.nickname,
                                  style: FontStyles.getHeaderTextStyle(),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  maxLines: 1,
                                ),
                                //author full name
                                Text(
                                  "${viewModel.users[index].user.surname} ${viewModel.users[index].user.name} ${viewModel.users[index].user.patronymic}",
                                  style: FontStyles.getHeaderTextStyle(),
                                ),
                              ],
                            ),
                          ),
                          if (viewModel.slaveSubs)
                            //Subscribe button
                            ElevatedButton(
                              onPressed:
                                  viewModel.users[index].slaveSubscription ==
                                          null
                                      ? () => viewModel
                                          .subscribe(viewModel.users[index])
                                      : null,
                              child: const Text("Subscribe"),
                            ),
                          if (viewModel.masterSubs)
                            //Confirmation button
                            viewModel.users[index].masterSubscription != null
                                ? ElevatedButton(
                                    onPressed: viewModel.users[index]
                                            .masterSubscription!.status
                                        ? () => viewModel
                                            .recallConfirmationSubscription(
                                                viewModel.users[index])
                                        : () => viewModel.confirmSubscription(
                                            viewModel.users[index]),
                                    child: Text(viewModel.users[index]
                                            .masterSubscription!.status
                                        ? "Recall"
                                        : "Confirm"),
                                  )
                                : const SizedBox.shrink(),
                        ],
                      )
                    ],
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: viewModel.users.length),
          ),
        ],
      );
    }
  }
}
