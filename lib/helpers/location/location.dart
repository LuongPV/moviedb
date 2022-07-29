import 'package:geolocator/geolocator.dart';

import '../../data/models/permission_action.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error(ServicePermissionAction.SERVICE_DISABLED);
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(ServicePermissionAction.DENIED_FOREVER);
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(ServicePermissionAction.DENIED);
    }
  }

  try {
    return await Geolocator.getCurrentPosition();
  } on LocationServiceDisabledException catch (e) {
    // On Xiaomi Devices, app can't get location although location service was enabled and the permissions were granted
    return Future.error(ServicePermissionAction.SERVICE_DISABLED);
  }
}