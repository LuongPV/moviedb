import '../models/login_data.dart';

abstract class AccountRepository {
  Future<LoginData?> getLoginData();

  Future<LoginData?> login(String username, String password);

  Future<void> logout();
}
