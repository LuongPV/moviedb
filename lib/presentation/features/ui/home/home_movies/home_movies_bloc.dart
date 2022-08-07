import '../../../../../domain/models/trending_media.dart';
import '../../../../../domain/models/trending_media_type.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../shared_blocs/base/base_bloc.dart';
import 'home_movies_events.dart';
import 'home_movies_states.dart';

class HomeMoviesBloc extends BaseBloc<HomeMoviesEvent, HomeMoviesState> {
  final TrendingRepository _trendingRepository;
  List<TrendingMedia> trendingMovies = [];

  HomeMoviesBloc(this._trendingRepository) : super(HomeMoviesInitial()) {
    processEvent<HomeGetTrendingMovies>((event, emit) async {
      emit(HomeMoviesTrendingLoading());
      final response =
          await _trendingRepository.getTrendingMedia(TrendingMediaType.movie);
      trendingMovies = response.results;
      emit(HomeMoviesTrendingLoaded(trendingMovies));
    });
    add(HomeGetTrendingMovies());
  }
}
