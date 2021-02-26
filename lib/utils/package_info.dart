import 'package:package_info/package_info.dart' as package_info_lib;

Future<String> getVersionName() async {
  var packageInfo = await package_info_lib.PackageInfo.fromPlatform();
  return packageInfo.version;
}