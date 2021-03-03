import 'package:movie_db/data/apis/account_api.dart';
import 'package:movie_db/data/models/login_data.dart';
import 'package:movie_db/data/prefs/account_prefs.dart';

class AccountRepository  {
  final _accountPrefs = AccountPrefs();
  final _accountAPI = AccountAPI();

  Future<LoginData> getLoginData() {
    return _accountPrefs.getLoginData();
  }

  Future<LoginData> login(String username, String password) async {
    var loginData = LoginData(username: username, password: password);
    final isLoginSuccess = await _accountAPI.login(loginData);
    if (isLoginSuccess) {
      _accountPrefs.saveLoginData(loginData);
      return loginData;
    }
    return null;
  }

  Future<void> logout() async {
    var isLogoutSuccess = await _accountAPI.logout();
    if (isLogoutSuccess) {
      _accountPrefs.clearLoginData();
    }
  }

}