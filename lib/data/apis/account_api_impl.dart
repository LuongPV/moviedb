import 'package:moviedb/data/apis/account_api.dart';

import '../models/login_data/login_data.dart';

class AccountApiImpl extends AccountApi {
  @override
  Future<bool> login(LoginData loginData) async {
    await Future.delayed(const Duration(seconds: 3));
    return loginData.username == 'aaa' && loginData.password == '111';
  }

  @override
  Future<bool> logout() async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }
}
