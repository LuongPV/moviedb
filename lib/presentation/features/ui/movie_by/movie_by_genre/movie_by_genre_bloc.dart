import '../../../../../domain/repositories/movie_repository.dart';
import '../../../shared_blocs/base/base_bloc.dart';
import 'movie_by_genre_events.dart';
import 'movie_by_genre_states.dart';

class MovieByGenreBloc extends BaseBloc<MovieByGenreEvent, MovieByGenreState> {
  final MovieRepository _movieRepository;
  final int _genreId;

  MovieByGenreBloc(this._movieRepository, this._genreId)
      : super(MovieByGenreInitial()) {
    processEvent<LoadMovieByGenre>((event, emit) async {
      final response = await _movieRepository.getMovieByGenre(_genreId);
      emit(MovieByGenreLoaded(response.results));
    });
    add(LoadMovieByGenre());
  }
}
