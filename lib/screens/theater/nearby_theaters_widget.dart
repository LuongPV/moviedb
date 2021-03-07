import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_db/data/models/permission_action.dart';
import 'package:movie_db/helpers/location/location.dart';
import 'package:movie_db/screens/base/base_stateful_widget.dart';
import 'package:movie_db/utils/logger/logger.dart';

class NearbyTheatersWidget extends BaseStatefulWidget {
  @override
  NearbyTheatersWidgetState createState() => NearbyTheatersWidgetState();
}

class NearbyTheatersWidgetState extends State<NearbyTheatersWidget> {
  static const MARKER_ID_CURRENT_POSITION = 'MARKER_ID_CURRENT_POSITION';
  Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    _mapController.future.then((controller) {
      Logger.d('Map init successfully');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(
              10.8109705,106.6668573
          ),
          zoom: 16
        ),
        onMapCreated: (controller) => _mapController.complete(controller),
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.pin_drop),
        onPressed: _currentPosition,
        label: Text(
          'Current Position'
        ),
      ),
    );
  }

  void _currentPosition() {
    _mapController.future.then((controller) async {
      try {
        final currentLocation = await determinePosition();
        Logger.d('Current location = $currentLocation');
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 16,
            ),
          ),
        );
        setState(() {
          markers.add(Marker(
            markerId: MarkerId(MARKER_ID_CURRENT_POSITION),
            position: LatLng(currentLocation.latitude, currentLocation.longitude),
            infoWindow: InfoWindow(
              title: 'Current Location',
            ),
          ));
        });
      } on ServicePermissionAction catch (e) {
        Logger.e('Location service error: $e');
        _handleLocationServiceError(e);
      }
    });
  }

  void _handleLocationServiceError(ServicePermissionAction e) {
    var errMsg;
    switch (e) {
      case ServicePermissionAction.SERVICE_DISABLED:
        errMsg = 'Location services are disabled.';
        break;
      case ServicePermissionAction.DENIED_FOREVER:
        errMsg = 'Location permissions are permanently denied, we cannot request permissions.';
        break;
      case ServicePermissionAction.DENIED:
        errMsg = 'Location permissions are denied';
        break;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: null,
          content: Text(errMsg),
          actions: [
            MaterialButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
