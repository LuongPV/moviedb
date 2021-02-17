import 'package:flutter/material.dart';
import 'package:movie_db/screens/home/home.dart';
import 'package:movie_db/utils/logger/logger.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logger.d('SplashWidget build');
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
    Logger.d('begin delayOpenHome');
    await Future.delayed(
      Duration(
        seconds: 10,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeWidget(),
      ),
    );
    Logger.d('end delayOpenHome');
  }
}
