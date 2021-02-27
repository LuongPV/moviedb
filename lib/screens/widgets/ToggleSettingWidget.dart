import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleSettingWidget extends StatefulWidget {
  final Function(bool) onSettingToggled;

  final String title;

  final String description;

  final Widget icon;

  final bool defaultValue;

  ToggleSettingWidget(this.title, this.description, this.icon, {this.defaultValue, this.onSettingToggled});

  @override
  _ToggleSettingWidgetState createState() => _ToggleSettingWidgetState();
}

class _ToggleSettingWidgetState extends State<ToggleSettingWidget> {
  var isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          widget.icon,
          SizedBox(
            width: 10,
          ),
          _buildLabel(),
          CustomSwitch(
            onChanged: _onSwitchToggled,
            value: isOn,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Expanded _buildLabel() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
            ),
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSwitchToggled(bool value) {
    setState(() {
      isOn = value;
      if (widget.onSettingToggled != null) {
        widget.onSettingToggled(value);
      }
    });
  }
}
