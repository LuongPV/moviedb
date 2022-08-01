import '../models/login_data/login_data.dart';

class AccountAPI {
  Future<bool> login(LoginData loginData) async {
    await Future.delayed(const Duration(seconds: 3));
    return loginData.username == 'aaa' && loginData.password == '111';
  }

  Future<bool> logout() async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }
}
