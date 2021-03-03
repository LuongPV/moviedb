import 'package:flutter/material.dart';
import 'package:movie_db/screens/base/base_state.dart';
import 'package:movie_db/screens/home/home_widget.dart';
import 'package:movie_db/screens/login/login_widget.dart';
import 'package:movie_db/screens/splash/splash_controller.dart';

class SplashWidget extends StatefulWidget {
  @override
  SplashWidgetState createState() => SplashWidgetState();
}

class SplashWidgetState extends BaseState<SplashWidget, SplashController> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.checkLogin();
    });
  }

  @override
  SplashController getController() => SplashController(this, context);

  @override
  Widget build(BuildContext context) {
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

  void openLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginWidget(),
      ),
    );
  }

  void openHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeWidget(),
      ),
    );
  }
}