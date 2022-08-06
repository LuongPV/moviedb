import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin BaseDialog {
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 20,
            ),
            Text(AppLocalizations.of(context)!.txtLoading),
          ],
        ),
      ),
    );
  }
}
