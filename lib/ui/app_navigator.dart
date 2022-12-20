import 'package:flutter/material.dart';
import 'package:post_gram_ui/ui/roots/create_post/create_post_widget.dart';
import 'package:post_gram_ui/ui/roots/main/main_widget.dart';
import 'package:post_gram_ui/ui/roots/auth/auth_widget.dart';
import 'package:post_gram_ui/ui/roots/loader/loader_widget.dart';
import 'package:post_gram_ui/ui/roots/profile/profile_widget.dart';
import 'package:post_gram_ui/ui/roots/registration/registration_widget.dart';

class NavigationRoutes {
  static const String loaderWidget = "/";
  static const String auth = "/auth";
  static const String main = "/main";
  static const String profile = "/profile";
  static const String registration = "/registration";
  static const String addPost = "/addPost";
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

  static Future toMain() async {
    return key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.main, ((route) => false));
  }

  static Future toProfile() async {
    return key.currentState?.pushNamed(NavigationRoutes.profile);
  }

  static Future toRegistration() async {
    return key.currentState?.pushNamed(NavigationRoutes.registration);
  }

  static Future toAddPost() async {
    return key.currentState?.pushNamed(NavigationRoutes.addPost);
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
            pageBuilder: ((_, __, ___) => MainWidget.create()));
      case NavigationRoutes.profile:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProfileWidget.create());
      case NavigationRoutes.registration:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => RegistrationWidget.create());
      case NavigationRoutes.addPost:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => CreatePostWidget.create());
    }
    return null;
  }
}
