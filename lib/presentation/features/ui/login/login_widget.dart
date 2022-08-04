import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_bloc.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginWidget extends StatelessWidget {
  final usernameInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: _buildAppLogoWidget(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 64),
                child: _buildUsernameWidget(context),
              ),
              const SizedBox(
                height: 16,
              ),
              _buildPasswordWidget(context),
              const SizedBox(
                height: 50,
              ),
              _buildLoginButtonWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Image _buildAppLogoWidget() {
    return Image.asset(
      'assets/images/ic_logo.png',
      width: 200,
    );
  }

  Material _buildLoginButtonWidget(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        child: Text(
          AppLocalizations.of(context)!.btnLogin,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () => BlocProvider.of<LoginBloc>(context).add(ValidateInputs(
          usernameInputController.text.trim(),
          passwordInputController.text.trim(),
        )),
        minWidth: 350,
      ),
    );
  }

  Widget _buildPasswordWidget(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      var errorText = '';
      if (state is PasswordInvalid) {
        errorText = AppLocalizations.of(context)!.errEmptyPassword;
      } else if (state is WrongPassword) {
        errorText = AppLocalizations.of(context)!.errWrongPassword;
      }
      return TextField(
        controller: passwordInputController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          icon: const Icon(Icons.lock_outline),
          hintText: AppLocalizations.of(context)!.txtPassword,
          labelText: AppLocalizations.of(context)!.txtPassword,
          errorText: errorText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
        ),
      );
    });
  }

  Widget _buildUsernameWidget(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      var errorText = '';
      if (state is UsernameInvalid) {
        errorText = AppLocalizations.of(context)!.errEmptyUsername;
      } else if (state is WrongUsername) {
        errorText = AppLocalizations.of(context)!.errWrongUsername;
      }
      return TextField(
        controller: usernameInputController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          icon: const Icon(Icons.person),
          hintText: AppLocalizations.of(context)!.txtUsername,
          labelText: AppLocalizations.of(context)!.txtUsername,
          errorText: errorText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
        ),
      );
    });
  }

  void openHomeWidget(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeWidget()));
  }
}