import 'package:flutter/material.dart';

abstract class BaseState<WidgetType extends StatefulWidget, ControllerType> extends State<WidgetType> {
  ControllerType controller;

  void updateUI() => setState(() {});

  ControllerType getController();

  @override
  void initState() {
    super.initState();
    controller = getController();
  }

}