import 'package:flutter/material.dart';
import 'package:movie_db/screens/base/base_state.dart';

abstract class BaseStatefulController <StateType extends BaseState> {
  StateType state;
  BuildContext context;

  BaseStatefulController(this.state, this.context);

  void updateUI() => state.updateUI();

}