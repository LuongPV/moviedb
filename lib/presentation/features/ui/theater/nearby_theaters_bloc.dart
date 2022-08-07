import '../../../../domain/repositories/place_repository.dart';
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
    processEvent<CheckNavigateLogin>((event, emit) {
      event.loginData != null ? emit(NavigateHome()) : emit(NavigateLogin());
    });

    add(NearbyTheaterOpen());
  }
}
