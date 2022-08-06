import 'package:flutter/material.dart';
import 'package:moviedb/presentation/features/ui/base/base_dialogs.dart';

abstract class BaseStatelessWidget extends StatelessWidget with BaseDialog {
  const BaseStatelessWidget({Key? key}) : super(key: key);
}
