import 'package:flutter/material.dart';
import 'package:moviedb/presentation/features/ui/base/base_dialogs.dart';

abstract class BaseStatefulWidget extends StatefulWidget with BaseDialog {
  const BaseStatefulWidget({Key? key}) : super(key: key);
}
