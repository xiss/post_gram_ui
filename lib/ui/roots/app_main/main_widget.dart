import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/roots/app_main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainViewModel viewModel = context.watch<MainViewModel>();
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(4),
            child: CircleAvatar(backgroundImage: viewModel.avater),
          ),
          title: Text(viewModel.name),
          actions: [
            IconButton(
                onPressed: viewModel.profile,
                icon: const Icon(Icons.account_box))
          ],
        ),
        body: null);
  }

  static dynamic create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MainViewModel(context: context),
      child: const MainWidget(),
    );
  }
}
