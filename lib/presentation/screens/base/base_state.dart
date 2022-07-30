import 'package:flutter/material.dart';

import 'base_stateful_controller.dart';

abstract class BaseState<WidgetType extends StatefulWidget, ControllerType extends BaseStatefulController<Object>> extends State<WidgetType> {
  ControllerType controller;

  void updateUI() => setState(() {});

  ControllerType getController();

  @override
  void initState() {
    super.initState();
    controller = getController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.stop();
  }

}