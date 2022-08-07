import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/ToggleSettingWidget.dart';
import '../../base/base_stateful_widget.dart';
import '../../login/login_widget.dart';
import 'home_settings_bloc.dart';
import 'home_settings_events.dart';
import 'home_settings_states.dart';

class HomeSettingsWidget extends BaseStatefulWidget {
  const HomeSettingsWidget({Key? key}) : super(key: key);

  @override
  HomeSettingsWidgetState createState() => HomeSettingsWidgetState();
}

class HomeSettingsWidgetState extends State<HomeSettingsWidget> {
  bool _isConfirmExit = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeSettingsBloc(
        RepositoryProvider.of(context),
        RepositoryProvider.of(context),
      ),
      child: Builder(builder: (context) {
        return BlocListener<HomeSettingsBloc, HomeSettingsStates>(
          listenWhen: (previous, current) => current is NavigateLogin,
          listener: ((context, state) => _openLogin()),
          child: BlocBuilder<HomeSettingsBloc, HomeSettingsStates>(
            builder: ((context, state) {
              if (state is HomeSettingsConfirmExitLoaded) {
                _isConfirmExit = state.isConfirmExit;
              }
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ToggleSettingWidget(
                      'Confirm exiting application',
                      "Press 'Back' twice to exit application",
                      _buildImage('assets/images/ic_exit.png'),
                      key: UniqueKey(),
                      defaultValue: _isConfirmExit,
                      onSettingToggled: (isOn) {
                        BlocProvider.of<HomeSettingsBloc>(context)
                            .add(HomeSettingsToggleConfirmExit(isOn));
                      },
                    ),
                    const Expanded(child: Material()),
                    _buildLogoutButton(context),
                  ],
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        child: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () => BlocProvider.of<HomeSettingsBloc>(context)
            .add(HomeSettingsRequestLogout()),
        minWidth: 350,
      ),
    );
  }

  Image _buildImage(String path) {
    return Image.asset(
      path,
      width: 30,
      height: 30,
    );
  }

  _openLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginWidget()));
  }
}
