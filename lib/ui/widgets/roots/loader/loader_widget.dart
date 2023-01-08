import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/roots/loader/loader_model.dart';
import 'package:provider/provider.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  static Widget create() => ChangeNotifierProvider<LoaderModel>(
        create: (context) => LoaderModel(context: context),
        lazy: false,
        child: const LoaderWidget(),
      );
}
