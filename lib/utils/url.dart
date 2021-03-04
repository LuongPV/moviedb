import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import 'logger/logger.dart';

void launchUrl(String url) async {
  if (Platform.isAndroid) {
    if (await canLaunch(url)) {
      Logger.d('Launch url $url');
      await launch(url);
    } else {
      Logger.w('Fail launch url $url');
    }
  }
}