import 'package:equatable/equatable.dart';

class LoginData extends Equatable {
  final String? username;
  final String? password;

  const LoginData(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}
