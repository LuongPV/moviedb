import 'package:flutter/material.dart';
import 'package:movie_db/data/models/user.dart';
import 'package:movie_db/screens/home/home.dart';

class LoginWidget extends StatelessWidget {
  final user = User();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset(
                    'assets/images/ic_logo.png',
                    width: 200,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 64),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Username',
                      labelText: 'Username',
                    ),
                    onSaved: _saveUsername,
                    validator: (username) => _validateUsername(username.trim()),
                  ),
                ),
                SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.lock_outline),
                    hintText: 'Password',
                    labelText: 'Password',
                  ),
                  onSaved: _savePassword,
                  validator: (password) => _validatePassword(password.trim()),
                ),
                SizedBox(height: 30,),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: FlatButton(
                    child: Text('Login'),
                    onPressed: login,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState.validate()) {
      Navigator.pushReplacement(formKey.currentContext, MaterialPageRoute(builder: (context) => HomeWidget()));
    }
  }

  void _saveUsername(String username) {
    user.username = username;
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

  void _savePassword(String password) {
    user.password = password;
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
