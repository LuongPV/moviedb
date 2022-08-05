import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../shared_blocs/base/base_bloc.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  String? usernameErrorText;
  String? passwordErrorText;

  LoginBloc() : super(LoginInitial()) {
    on<ValidateInputs>((event, emit) {
      emit(ErrorCleared());
      var isInputsValid = true;
      if (!_isUsernameValid(event.username)) {
        emit(UsernameInvalid());
        isInputsValid = false;
      }
      if (!_isPasswordValid(event.password)) {
        emit(PasswordInvalid());
        isInputsValid = false;
      }
      if (isInputsValid) {
        emit(InputsValid());
      }
    }, transformer: sequential());
  }

  void login(String username, String password) {
    usernameErrorText = _isUsernameValid(username);
    passwordErrorText = _isPasswordValid(password);
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

  bool _isUsernameValid(String username) {
    return username.isNotEmpty && username.length >= 3;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty && password.length >= 3;
  }
}
