abstract class LoginState {}

class LoginInitial extends LoginState {}

class UsernameInvalid extends LoginState {}

class WrongUsername extends LoginState {}

class PasswordInvalid extends LoginState {}

class WrongPassword extends LoginState {}

class InputsValid extends LoginState {}