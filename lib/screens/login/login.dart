import 'package:flutter/material.dart';
import 'package:movie_db/screens/home/home.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  var usernameErrorText;

  var passwordErrorText;

  final usernameInputController = TextEditingController();

  final passwordInputController = TextEditingController();

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
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w200,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: login,
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
        hintText: 'Password',
        labelText: 'Password',
        errorText: passwordErrorText,
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
        hintText: 'Username',
        labelText: 'Username',
        errorText: usernameErrorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
    );
  }

  void login() {
    setState(() {
      usernameErrorText =
          _validateUsername(usernameInputController.text.trim());
      passwordErrorText =
          _validatePassword(passwordInputController.text.trim());
      if (usernameErrorText == null && passwordErrorText == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeWidget()));
      }
    });
  }

  String _validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username must not be empty';
    }
    if (username != 'aaa') {
      return 'Wrong username';
    }
    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password must not be empty';
    }
    if (password != '111') {
      return 'Wrong password';
    }
    return null;
  }
}
