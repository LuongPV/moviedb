import 'package:geolocator/geolocator.dart';
import 'package:moviedb/data/constants.dart';

import '../../../../data/models/permission_action.dart';
import '../../../../data/services/location/location.dart';
import '../../../../domain/repositories/place_repository.dart';
import '../../../utils/logger/logger.dart';
import '../../shared_blocs/base/base_bloc.dart';
import 'nearby_theaters_events.dart';
import 'nearby_theaters_states.dart';

class NearbyTheaterBloc
    extends BaseBloc<NearbyTheaterEvent, NearbyTheaterState> {
  final PlaceRepository _placeRepository;

  NearbyTheaterBloc(this._placeRepository) : super(NearbyTheaterInitial()) {
    processEvent<NearbyTheaterOpen>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      emit(NearbyTheaterTimeout());
    });
    processEvent<GetLocation>((event, emit) async {
      try {
        Position currentLocation = await determinePosition();
        Logger.d('Current location = $currentLocation');
        emit(
          LocationLoaded(currentLocation.latitude, currentLocation.longitude),
        );
        final response = await _placeRepository.getNearbyPlaces(
            currentLocation.latitude,
            currentLocation.longitude,
            placeTypeMovieTheater);
        emit(NearbyPlacesLoaded(response.results));
      } on ServicePermissionAction catch (e) {
        Logger.e('Location service error: $e');
        emit(LocationServiceErrorTriggered(e));
      }
    });
    processEvent<GetDirection>((event, emit) async {
      final currentLocation = await determinePosition();
      final response = await _placeRepository.getDirection(
        currentLocation.latitude,
        currentLocation.longitude,
        event.latitude,
        event.longitude,
      );
      emit(NearbyDirectionLoaded(response.routes));
    });

    add(NearbyTheaterOpen());
  }
}
