import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_blocs/auth/auth_bloc.dart';
import '../../shared_blocs/auth/auth_events.dart';
import '../../shared_blocs/auth/auth_states.dart';
import '../base/base_stateless_widget.dart';
import '../login/login_widget.dart';
import 'splash_bloc.dart';
import 'splash_events.dart';
import 'splash_states.dart';

class SplashWidget extends BaseStatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((_) => SplashBloc()),
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<SplashBloc, SplashState>(listener: ((context, state) {
              switch (state.runtimeType) {
                case SplashTimeout:
                  BlocProvider.of<AuthBloc>(context).add(CheckLogin());
                  break;
                case NavigateHome:
                  _openHome(context);
                  break;
                case NavigateLogin:
                  _openLogin(context);
                  break;
              }
            })),
            BlocListener<AuthBloc, AuthState>(listener: ((context, state) {
              switch (state.runtimeType) {
                case LoginDataLoaded:
                  BlocProvider.of<SplashBloc>(context).add(
                      CheckNavigateLogin((state as LoginDataLoaded).loginData));
                  break;
              }
            })),
          ],
          child: Scaffold(
            body: Center(
              child: Image.asset(
                'assets/images/ic_logo.png',
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
    );
  }

  void _openLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginWidget(),
      ),
    );
  }

  void _openHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeWidget(),
      ),
    );
  }
}
