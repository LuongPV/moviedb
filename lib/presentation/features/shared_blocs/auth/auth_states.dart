import '../../../../domain/models/login_data.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginDataLoaded extends AuthState {
  final LoginData? loginData;

  LoginDataLoaded(this.loginData);
}
