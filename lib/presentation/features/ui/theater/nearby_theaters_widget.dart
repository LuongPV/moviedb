import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../data/models/permission_action.dart';
import '../../../../domain/models/direction_response.dart';
import '../../../utils/dialog.dart';
import '../../../utils/logger/logger.dart';
import '../base/base_stateful_widget.dart';
import 'nearby_theaters_bloc.dart';
import 'nearby_theaters_events.dart';
import 'nearby_theaters_states.dart';

class NearbyTheatersWidget extends BaseStatefulWidget {
  const NearbyTheatersWidget({Key? key}) : super(key: key);

  @override
  _NearbyTheatersWidgetState createState() => _NearbyTheatersWidgetState();
}

class _NearbyTheatersWidgetState extends State<NearbyTheatersWidget> {
  static const markerIdCurrentPosition = 'markerIdCurrentPosition';
  static const markerIdNearby = 'markerIdNearby';
  static const polylineIdString = 'polylineIdString';
  var nearbyPlaceId = 0;
  var polylineId = 0;
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() async {
    super.initState();
    await _mapController.future;
    Logger.d('Map init successfully');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NearbyTheaterBloc(RepositoryProvider.of(context)),
      child: Builder(builder: (context) {
        return BlocListener(
          listener: (context, state) async {
            switch (state.runtimeType) {
              case LocationLoaded:
                final controller = await _mapController.future;
                final locationState = state as LocationLoaded;
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                        locationState.latitude,
                        locationState.longitude,
                      ),
                      zoom: 16,
                    ),
                  ),
                );
                setState(() {
                  _markers.add(Marker(
                    markerId: const MarkerId(markerIdCurrentPosition),
                    position: LatLng(
                      locationState.latitude,
                      locationState.longitude,
                    ),
                    infoWindow: const InfoWindow(
                      title: 'Current Location',
                    ),
                  ));
                });
                break;
              case LocationServiceErrorTriggered:
                _handleLocationServiceError(
                    (state as LocationServiceErrorTriggered).permissionAction);
                break;
              case NearbyPlacesLoaded:
                final places = (state as NearbyPlacesLoaded).places;
                if (places.isNotEmpty) {
                  nearbyPlaceId = 0;
                  _markers.removeWhere((marker) =>
                      marker.markerId.value.contains(markerIdNearby));
                }
                final nearbyMarkers = places.map((result) {
                  nearbyPlaceId++;
                  return Marker(
                      markerId: MarkerId(
                        markerIdNearby + nearbyPlaceId.toString(),
                      ),
                      position: LatLng(
                        result.geometry.location.lat,
                        result.geometry.location.lng,
                      ),
                      infoWindow: InfoWindow(
                        title: result.name,
                        snippet: result.vicinity,
                      ),
                      onTap: () =>
                          BlocProvider.of<NearbyTheaterBloc>(context).add(
                            GetDirection(
                              result.geometry.location.lat,
                              result.geometry.location.lng,
                            ),
                          ));
                }).toSet();
                setState(() {
                  _markers.addAll(nearbyMarkers);
                });
                break;
              case NearbyDirectionLoaded:
                List<Routes> routes = (state as NearbyDirectionLoaded).routes;
                if (routes.isNotEmpty) {
                  _polylines.clear();
                  final polylinePoints = PolylinePoints();
                  List<PointLatLng> results = polylinePoints
                      .decodePolyline(routes.first.overviewPolyline.points);
                  _polylines.add(Polyline(
                    polylineId:
                        PolylineId(polylineIdString + polylineId.toString()),
                    color: Colors.blue,
                    width: 6,
                    points: results
                        .map((result) =>
                            LatLng(result.latitude, result.longitude))
                        .toList(),
                  ));
                  setState(() {});
                }
                break;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Nearby Cinemas'),
            ),
            body: GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(10.8109705, 106.6668573), zoom: 16),
              onMapCreated: (controller) => _mapController.complete(controller),
              markers: _markers,
              polylines: _polylines,
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(Icons.pin_drop),
              onPressed: () async => BlocProvider.of<NearbyTheaterBloc>(context)
                  .add(GetLocation()),
              label: const Text('Current Position'),
            ),
          ),
        );
      }),
    );
  }

  void _handleLocationServiceError(ServicePermissionAction e) {
    switch (e) {
      case ServicePermissionAction.serviceDisabled:
        showConfirmationDialog(context, 'Location services are disabled.',
            textAction: 'Open Location Settings', action: () {
          Geolocator.openLocationSettings();
        });
        break;
      case ServicePermissionAction.deniedForever:
        showConfirmationDialog(context,
            'Location permissions are permanently denied, we cannot request permissions.',
            textAction: 'Open Settings', action: () {
          Geolocator.openAppSettings();
        });
        break;
      case ServicePermissionAction.denied:
        showInformationDialog(context, 'Location permissions are denied');
        break;
    }
  }
}
