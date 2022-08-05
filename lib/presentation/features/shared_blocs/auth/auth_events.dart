abstract class AuthEvent {}

class CheckLogin extends AuthEvent {}

class RequestLogin extends AuthEvent {
  final String username;
  final String password;

  RequestLogin(this.username, this.password);
}
