import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_data/login_data.dart';

class AccountPrefs {
  static const String prefLoginData = 'prefLoginData';

  _getSharedPreferences() async => await SharedPreferences.getInstance();

  Future<LoginData?> getLoginData() async {
    final json = (await _getSharedPreferences()).getString(prefLoginData);
    if (json == null) {
      return null;
    }
    return LoginData.fromJson(jsonDecode(json));
  }

  void saveLoginData(LoginData loginData) async {
    (await _getSharedPreferences()).setString(
      prefLoginData,
      jsonEncode(loginData.toJson()),
    );
  }

  void clearLoginData() async {
    (await _getSharedPreferences()).setString(prefLoginData, null);
  }
}
