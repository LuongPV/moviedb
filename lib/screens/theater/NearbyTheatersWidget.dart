import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_db/screens/base/base_stateful_widget.dart';
import 'package:movie_db/utils/logger/logger.dart';

class NearbyTheatersWidget extends BaseStatefulWidget {
  @override
  NearbyTheatersWidgetState createState() => NearbyTheatersWidgetState();
}

class NearbyTheatersWidgetState extends State<NearbyTheatersWidget> {
  Completer<GoogleMapController> _mapController = Completer();

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
    _mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(10.7910389, 106.6784616),
            zoom: 16,
          ),
        ),
      );
    });
  }
}
