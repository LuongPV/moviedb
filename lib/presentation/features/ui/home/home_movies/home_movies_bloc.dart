import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../../../domain/models/trending_media.dart';
import '../../../../../domain/models/trending_media_type.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../shared_blocs/base/base_bloc.dart';
import 'home_movies_events.dart';
import 'home_movies_states.dart';

class HomeMoviesBloc extends BaseBloc<HomeMoviesEvents, HomeMoviesStates> {
  final TrendingRepository _trendingRepository;
  List<TrendingMedia> trendingMovies = [];

  HomeMoviesBloc(this._trendingRepository) : super(HomeMoviesInitial()) {
    on<HomeGetTrendingMovies>((event, emit) {
      emit(HomeMoviesTrendingLoading());
      _trendingRepository
          .getTrendingMedia(TrendingMediaType.movie)
          .then((response) {
        trendingMovies = response.results;
        emit(HomeMoviesTrendingLoaded(trendingMovies));
      });
    }, transformer: sequential());
    add(HomeGetTrendingMovies());
  }
}
