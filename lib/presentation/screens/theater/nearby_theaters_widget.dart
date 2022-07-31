import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/permission_action.dart';
import '../../data/repositories/place_repository.dart';
import '../../helpers/location/location.dart';
import '../../utils/dialog.dart';
import '../../utils/logger/logger.dart';
import '../base/base_stateful_widget.dart';

class NearbyTheatersWidget extends BaseStatefulWidget {
  @override
  NearbyTheatersWidgetState createState() => NearbyTheatersWidgetState();
}

class NearbyTheatersWidgetState extends State<NearbyTheatersWidget> {
  static const MARKER_ID_CURRENT_POSITION = 'MARKER_ID_CURRENT_POSITION';
  static const MARKER_ID_NEAR_BY = 'MARKER_ID_NEAR_BY_';
  static const POLYLINE_ID = 'POLYLINE_ID_';
  var nearbyPlaceId = 0;
  var polylineId = 0;
  Completer<GoogleMapController> _mapController = Completer();
  final _placeRepository = PlaceRepository();
  Set<Marker> markers = Set();
  Set<Polyline> polylines = Set();

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
      appBar: AppBar(
        title: Text('Nearby Cinemas'),
      ),
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
        polylines: polylines,
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
      Position currentLocation;
      try {
        currentLocation = await determinePosition();
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
      return currentLocation;
    }).then((location) async {
      if (location != null) {
        final response = await _placeRepository.getNearbyPlaces(location.latitude, location.longitude, PLACE_TYPE_MOVIE_THEATER);
        if (response.results.isNotEmpty) {
          nearbyPlaceId = 0;
          markers.removeWhere((marker) => marker.markerId.value.contains(MARKER_ID_NEAR_BY));
        }
        final nearbyMarkers = response.results.map((result) {
          nearbyPlaceId++;
          return Marker(
            markerId: MarkerId(MARKER_ID_NEAR_BY + nearbyPlaceId.toString()),
            position: LatLng(result.geometry.location.lat, result.geometry.location.lng),
            infoWindow: InfoWindow(
              title: result.name,
              snippet: result.vicinity,
            ),
            onTap: () => _getDirectionMarker(result.geometry.location.lat, result.geometry.location.lng)
          );
        }).toSet();
        setState(() {
          markers.addAll(nearbyMarkers);
        });
      }
    });
  }

  void _handleLocationServiceError(ServicePermissionAction e) {
    switch (e) {
      case ServicePermissionAction.serviceDisabled:
        showConfirmationDialog(context, 'Location services are disabled.', textAction: 'Open Location Settings', action: () {
          Geolocator.openLocationSettings();
        });
        break;
      case ServicePermissionAction.deniedForever:
        showConfirmationDialog(context, 'Location permissions are permanently denied, we cannot request permissions.', textAction: 'Open Settings', action: () {
          Geolocator.openAppSettings();
        });
        break;
      case ServicePermissionAction.denied:
        showInformationDialog(context, 'Location permissions are denied');
        break;
    }
  }

  void _getDirectionMarker(double lat, double lng) async {
    final currentLocation = await determinePosition();
    final response = await _placeRepository.getDirection(currentLocation.latitude, currentLocation.longitude, lat, lng);
    if (response.routes.isNotEmpty) {
      polylines.clear();
      final polylinePoints = PolylinePoints();
      List<PointLatLng> results = polylinePoints.decodePolyline(response.routes.first.overviewPolyline.points);
      polylines.add(Polyline(
          polylineId: PolylineId(POLYLINE_ID + polylineId.toString()),
          color: Colors.blue,
          width: 6,
          points: results.map((result) => LatLng(result.latitude, result.longitude)).toList(),
      ));
      setState(() {});
    }
  }
}
