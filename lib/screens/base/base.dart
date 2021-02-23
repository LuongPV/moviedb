import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseStatefulWidget extends StatefulWidget {

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _getDialog(context),
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _getDialog(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            SizedBox(width: 20,),
            new Text(AppLocalizations.of(context).txtLoading),
          ],
        ),
      ),
    );
  }

}