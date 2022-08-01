import 'package:moviedb/data/models/login_data/login_data_mapper.dart';
import 'package:moviedb/domain/repositories/account_repository.dart';

import '../../domain/models/login_data.dart';
import '../apis/account_api.dart';
import '../prefs/account_prefs.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountAPI _accountAPI;
  final AccountPrefs _accountPrefs;

  AccountRepositoryImpl(this._accountAPI, this._accountPrefs);

  @override
  Future<LoginData?> getLoginData() async {
    return LoginDataMapper().convertToDomain(await _accountPrefs.getLoginData());
  }

  @override
  Future<LoginData?> login(String username, String password) async {
    var loginData = LoginData(username, password);
    final isLoginSuccess =await _accountAPI.login(LoginDataMapper().convertToData(loginData)!);
    if (isLoginSuccess) {
      _accountPrefs.saveLoginData(LoginDataMapper().convertToData(loginData)!);
      return loginData;
    }
    return null;
  }

  @override
  Future<void> logout() async {
    var isLogoutSuccess = await _accountAPI.logout();
    if (isLogoutSuccess) {
      _accountPrefs.clearLoginData();
    }
  }
}
