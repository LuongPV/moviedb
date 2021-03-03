import 'package:flutter/cupertino.dart';
import 'package:movie_db/data/repositories/account_repository.dart';
import 'package:movie_db/screens/splash/splash_widget.dart';

class SplashController {
  SplashWidgetState loginWidgetState;
  BuildContext context;
  AccountRepository _accountRepository = AccountRepository();

  SplashController(this.loginWidgetState, this.context);

  void checkLogin() {
    Future.delayed(
      Duration(
        seconds: 3,
      ),
    ).then((_) async {
      final loginData = await _accountRepository.getLoginData();
      if (loginData == null) {
        loginWidgetState.openLogin();
      } else {
        loginWidgetState.openHome();
      }
    });
  }

}
