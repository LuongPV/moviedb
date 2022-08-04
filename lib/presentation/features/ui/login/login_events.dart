abstract class LoginEvent {}

class ValidateInputs extends LoginEvent {
  final String username;
  final String password;

  ValidateInputs(this.username, this.password);
}
