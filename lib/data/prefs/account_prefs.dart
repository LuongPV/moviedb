import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_data.dart';

class AccountPrefs {
  static const String PREF_LOGIN_DATA = 'PREF_LOGIN_DATA';

  _getSharedPreferences() async => await SharedPreferences.getInstance();

  Future<LoginData> getLoginData() async {
    final json = (await _getSharedPreferences()).getString(PREF_LOGIN_DATA);
    if (json == null) {
      return null;
    }
    return LoginData.fromJson(jsonDecode(json));
  }

  void saveLoginData(LoginData loginData) async {
    (await _getSharedPreferences()).setString(PREF_LOGIN_DATA, jsonEncode(loginData.toJson()));
  }

  void clearLoginData() async {
    (await _getSharedPreferences()).setString(PREF_LOGIN_DATA, null);
  }
}
