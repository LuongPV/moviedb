import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_db/screens/base/base_state.dart';

abstract class BaseStatefulController <StateType extends BaseState> {
  StateType state;
  BuildContext context;
  final _subscriptions = <StreamSubscription>[];

  BaseStatefulController(this.state, this.context);

  void updateUI() => state.updateUI();

  void stop() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    state = null;
  }

}

extension Queue on Future {
  void enqueue(BaseStatefulController controller, Function(dynamic) callback) {
    controller._subscriptions.add(this.asStream().listen(callback));
  }
}