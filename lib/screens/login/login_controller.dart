import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_widget.dart';

class LoginController {
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
        loginWidgetState.openHomeWidget();
      }
    });
  }

  String _validateUsername(String username) {
    if (username.isEmpty) {
      return AppLocalizations.of(context).errEmptyUsername;
    }
    if (username != 'aaa') {
      return AppLocalizations.of(context).errEmptyPassword;
    }
    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return AppLocalizations.of(context).errEmptyPassword;
    }
    if (password != '111') {
      return AppLocalizations.of(context).errWrongPassword;
    }
    return null;
  }
}
