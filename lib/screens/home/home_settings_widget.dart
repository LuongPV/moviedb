import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/global_variables.dart';
import 'package:movie_db/screens/widgets/ToggleSettingWidget.dart';

class HomeSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ToggleSettingWidget(
            'Confirm exiting application',
            "Press 'Back' twice to exit application",
            _buildImage('assets/images/ic_exit.png'),
            defaultValue: isConfirmExit,
            onSettingToggled: (isOn) => isConfirmExit = isOn,
          ),
        ],
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
}
