import 'package:flutter/material.dart';
import 'package:movie_db/screens/login/login.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      delayOpenHome(context);
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/ic_logo.png',
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void delayOpenHome(BuildContext context) async {
    await Future.delayed(
      Duration(
        seconds: 3,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginWidget(),
      ),
    );
  }
}
