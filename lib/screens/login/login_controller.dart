import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_db/data/repositories/account_repository.dart';

import 'login_widget.dart';

class LoginController {
  AccountRepository _accountRepository = AccountRepository();
  LoginWidgetState loginWidgetState;
  BuildContext context;
  var usernameErrorText;
  var passwordErrorText;

  LoginController(this.loginWidgetState, this.context);

  void login(String username, String password) {
    loginWidgetState.updateUI(() {
      usernameErrorText = _validateUsername(username);
      passwordErrorText = _validatePassword(password);
      if (usernameErrorText == null && passwordErrorText == null) {
        loginWidgetState.widget.showLoadingDialog(context);
        _accountRepository.login(username, password).then((loginData) {
          loginWidgetState.updateUI(() {
            loginWidgetState.widget.hideLoadingDialog(context);
            if (loginData == null) {
              usernameErrorText = AppLocalizations.of(context).errWrongUsername;
              usernameErrorText = AppLocalizations.of(context).errWrongPassword;
            } else {
              loginWidgetState.openHomeWidget();
            }
          });
        });
      }
    });
  }

  String _validateUsername(String username) {
    if (username.isEmpty) {
      return AppLocalizations.of(context).errEmptyUsername;
    }
    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return AppLocalizations.of(context).errEmptyPassword;
    }
    return null;
  }
}
