import 'package:package_info_plus/package_info_plus.dart' as package_info_lib;

Future<String> getVersionName() async {
  var packageInfo = await package_info_lib.PackageInfo.fromPlatform();
  return packageInfo.version;
}