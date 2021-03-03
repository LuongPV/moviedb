import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/base/base_state.dart';
import 'package:movie_db/screens/home/home_settings_controller.dart';
import 'package:movie_db/screens/login/login_widget.dart';
import 'package:movie_db/screens/widgets/ToggleSettingWidget.dart';

class HomeSettingsWidget extends BaseStatefulWidget {
  @override
  HomeSettingsWidgetState createState() => HomeSettingsWidgetState();
}

class HomeSettingsWidgetState
    extends BaseState<HomeSettingsWidget, HomeSettingsController> {
  @override
  void initState() {
    super.initState();
    controller.initConfirmExit();
  }

  @override
  HomeSettingsController getController() =>
      HomeSettingsController(this, context);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ToggleSettingWidget(
            'Confirm exiting application',
            "Press 'Back' twice to exit application",
            _buildImage('assets/images/ic_exit.png'),
            key: UniqueKey(),
            defaultValue: controller.isConfirmExit,
            onSettingToggled: (isOn) {
              controller.setConfirmExit(isOn);
            },
          ),
          Expanded(child: Material()),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        child: Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed:  () => controller.logout(),
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

  openLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginWidget()));
  }
}
