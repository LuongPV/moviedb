import '../../data/repositories/account_repository.dart';
import '../base/base_stateful_controller.dart';
import 'login_widget.dart';

class LoginController extends BaseStatefulController<LoginWidgetState> {
  AccountRepository _accountRepository = AccountRepository();
  var usernameErrorText;
  var passwordErrorText;

  LoginController(state, context) : super(state, context);

  void login(String username, String password) {
    usernameErrorText = _validateUsername(username);
    passwordErrorText = _validatePassword(password);
    updateUI();
    if (usernameErrorText == null && passwordErrorText == null) {
      state.widget.showLoadingDialog(context);
      _accountRepository.login(username, password).then((loginData) {
        state.widget.hideLoadingDialog(context);
        if (loginData == null) {
          usernameErrorText = AppLocalizations.of(context).errWrongUsername;
          usernameErrorText = AppLocalizations.of(context).errWrongPassword;
          updateUI();
        } else {
          state.openHomeWidget();
        }
      });
    }
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
