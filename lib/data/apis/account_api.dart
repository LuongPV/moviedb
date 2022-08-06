import '../models/login_data/login_data.dart';

abstract class AccountApi {
  Future<bool> login(LoginData loginData);

  Future<bool> logout();
}
