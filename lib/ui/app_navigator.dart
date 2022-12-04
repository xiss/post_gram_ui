import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/roots/app_main.dart';
import 'package:post_gram_ui/ui/roots/auth_widget.dart';
import 'package:post_gram_ui/ui/roots/loader_widget.dart';
import 'package:post_gram_ui/ui/roots/profile_widget.dart';

class NavigationRoutes {
  static const String loaderWidget = "/";
  static const String auth = "/auth";
  static const String main = "/main";
  static const String profile = "/profile";
}

class AppNavigator {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static void toLoader() {
    key.currentState?.pushNamedAndRemoveUntil(
        NavigationRoutes.loaderWidget, ((route) => false));
  }

  static void toAuth() {
    key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.auth, ((route) => false));
  }

  static void toMain() {
    key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.main, ((route) => false));
  }

  static void toProfile() {
    key.currentState?.pushNamed(NavigationRoutes.profile);
  }

  static Route<dynamic>? onGeneratedRoutes(RouteSettings settings, context) {
    switch (settings.name) {
      case NavigationRoutes.loaderWidget:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => LoaderWidget.create()));
      case NavigationRoutes.auth:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => AuthWidget.create()));
      case NavigationRoutes.main:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => AppMainWidget.create()));
      case NavigationRoutes.profile:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProfileWidget.create());
    }
    return null;
  }
}
