import 'package:movie_db/data/models/login_data.dart';

class AccountAPI {
  Future<bool> login(LoginData loginData) async {
    await Future.delayed(Duration(seconds: 3));
    if (loginData != null &&
        loginData.username == 'aaa' &&
        loginData.password == '111') {
      return true;
    }
    return false;
  }

  Future<bool> logout() async {
    await Future.delayed(Duration(seconds: 3));
    return true;
  }
}
