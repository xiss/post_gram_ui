import 'package:flutter/material.dart';
import 'package:post_gram_ui/internal/itit_app.dart';
import 'package:post_gram_ui/ui/navigation/app_navigator.dart';
import 'package:post_gram_ui/ui/widgets/roots/loader/loader_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
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
