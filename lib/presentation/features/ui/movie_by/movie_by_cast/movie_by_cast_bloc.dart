import '../../../../../domain/repositories/movie_repository.dart';
import '../../../shared_blocs/base/base_bloc.dart';
import 'movie_by_cast_events.dart';
import 'movie_by_cast_states.dart';

class MovieByCastBloc extends BaseBloc<MovieByCastEvent, MovieByCastState> {
  final MovieRepository _movieRepository;
  final int _castId;

  MovieByCastBloc(this._movieRepository, this._castId)
      : super(MovieByCastInitial()) {
    processEvent<LoadMovieByCast>((event, emit) async {
      final response = await _movieRepository.getMovieByCast(_castId);
      emit(MovieByCastLoaded(response.cast));
    });
    add(LoadMovieByCast());
  }
}
