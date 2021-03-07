import 'package:flutter/material.dart';

void showInformationDialog(BuildContext context, String content, {String title}) {
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
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}