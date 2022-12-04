import 'dart:convert';

import 'package:post_gram_ui/domain/models/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _userKey = "_UserKey";

  static Future<UserModel?> getStoredUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserModel? model;
    String? jsonUser = sharedPreferences.getString(_userKey);
    if (jsonUser != null && jsonUser != "") {
      model = UserModel.fromJson(jsonDecode(jsonUser));
    }

    return model;
  }

  static Future setStoredUser(UserModel? model) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (model == null) {
      sharedPreferences.remove(_userKey);
    } else {
      sharedPreferences.setString(_userKey, jsonEncode(model.toJson()));
    }
  }
}
