import 'package:flutter/material.dart';

void showInformationDialog(BuildContext context, String content,
    {String? title}) {
  showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: title != null ? Text(title) : null,
            content: Text(content),
            actions: [
              MaterialButton(
                child: Text(
                  'OK',
                  style: _getButtonStyle(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}

void showConfirmationDialog(
  BuildContext context,
  String content, {
  String? title,
  String textAction = 'Cancel',
  void Function()? action,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: title != null ? Text(title) : null,
            content: Text(content),
            actions: [
              MaterialButton(
                child: Text(
                  textAction,
                  style: _getButtonStyle(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (action != null) {
                    action();
                  }
                },
              ),
              MaterialButton(
                child: Text(
                  'OK',
                  style: _getButtonStyle(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}

TextStyle _getButtonStyle() {
  return TextStyle(fontWeight: FontWeight.w600, fontSize: 18);
}
