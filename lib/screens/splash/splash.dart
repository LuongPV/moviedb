import 'package:flutter/material.dart';
import 'package:movie_db/screens/login/login_widget.dart';

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      delayOpenHome(context);
    });
  }

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

  void delayOpenHome(BuildContext context) {
    Future.delayed(
      Duration(
        seconds: 3,
      ),
    ).then((_) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginWidget(),
      ),
    ));
  }
}