import '../apis/account_api.dart';
import '../models/login_data.dart';
import '../prefs/account_prefs.dart';

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