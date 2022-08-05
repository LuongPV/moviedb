abstract class LoginState {}

class LoginInitial extends LoginState {}

class ErrorCleared extends LoginState {}

class UsernameInvalid extends LoginState {}

class PasswordInvalid extends LoginState {}

class InputsValid extends LoginState {}