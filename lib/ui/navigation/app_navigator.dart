import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/widgets/roots/app/app_widget.dart';
import 'package:post_gram_ui/ui/widgets/roots/auth/auth_widget.dart';
import 'package:post_gram_ui/ui/widgets/roots/loader/loader_widget.dart';
import 'package:post_gram_ui/ui/widgets/roots/registration/registration_widget.dart';

class NavigationRoutes {
  static const String loaderWidget = "/";
  static const String auth = "/auth";
  static const String app = "/app";
  static const String registration = "/registration";
}

class AppNavigator {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static Future toLoader() async {
    return key.currentState?.pushNamedAndRemoveUntil(
        NavigationRoutes.loaderWidget, ((route) => false));
  }

  static Future toAuth() async {
    return key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.auth, ((route) => false));
  }

  static Future toApp() async {
    return key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.app, ((route) => false));
  }

  static Route<dynamic>? onGeneratedRoutes(RouteSettings settings, context) {
    switch (settings.name) {
      case NavigationRoutes.loaderWidget:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => LoaderWidget.create()));
      case NavigationRoutes.auth:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => AuthWidget.create()));
      case NavigationRoutes.app:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => AppWidget.create()));
      case NavigationRoutes.registration:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => RegistrationWidget.create()));
    }
    return null;
  }
}
