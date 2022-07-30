import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../base/base_state.dart';
import '../base/base_stateful_widget.dart';
import '../home/home_widget.dart';
import 'login_controller.dart';

class LoginWidget extends BaseStatefulWidget {
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends BaseState<LoginWidget, LoginController> {
  final usernameInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  LoginController getController() => LoginController(this, context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: _buildAppLogoWidget(),
              ),
              Container(
                margin: EdgeInsets.only(top: 64),
                child: _buildUsernameWidget(),
              ),
              SizedBox(
                height: 16,
              ),
              _buildPasswordWidget(),
              SizedBox(
                height: 50,
              ),
              _buildLoginButtonWidget(),
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

  Material _buildLoginButtonWidget() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        child: Text(
          AppLocalizations.of(context).btnLogin,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () => controller.login(usernameInputController.text.trim(),
            passwordInputController.text.trim()),
        minWidth: 350,
      ),
    );
  }

  TextField _buildPasswordWidget() {
    return TextField(
      controller: passwordInputController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        icon: Icon(Icons.lock_outline),
        hintText: AppLocalizations.of(context).txtPassword,
        labelText: AppLocalizations.of(context).txtPassword,
        errorText: controller.passwordErrorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
    );
  }

  TextField _buildUsernameWidget() {
    return TextField(
      controller: usernameInputController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        icon: Icon(Icons.person),
        hintText: AppLocalizations.of(context).txtUsername,
        labelText: AppLocalizations.of(context).txtUsername,
        errorText: controller.usernameErrorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
    );
  }

  void openHomeWidget() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeWidget()));
  }
}
