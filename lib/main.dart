import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';
import 'package:post_gram_ui/ui/roots/loader_widget.dart';

void main() {
  runApp(const PostGram());
}

class PostGram extends StatelessWidget {
  const PostGram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PostGram',
      navigatorKey: AppNavigator.key,
      onGenerateRoute: (settings) =>
          AppNavigator.onGeneratedRoutes(settings, context),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoaderWidget.create(),
    );
  }
}
