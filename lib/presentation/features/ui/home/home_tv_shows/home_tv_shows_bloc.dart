import '../../../../../domain/models/trending_media.dart';
import '../../../../../domain/models/trending_media_type.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../shared_blocs/base/base_bloc.dart';
import 'home_tv_shows_events.dart';
import 'home_tv_shows_states.dart';

class HomeTvShowsBloc extends BaseBloc<HomeTvShowsEvent, HomeTvShowsState> {
  final TrendingRepository _trendingRepository;
  List<TrendingMedia> trendingTvShows = [];

  HomeTvShowsBloc(this._trendingRepository) : super(HomeTvShowsInitial()) {
    processEvent<HomeGetTrendingTvShows>((event, emit) {
      emit(HomeTvShowsLoading());
      _trendingRepository
          .getTrendingMedia(TrendingMediaType.tvShow)
          .then((response) {
        trendingTvShows = response.results;
        emit(HomeTvShowsLoaded(trendingTvShows));
      });
    });
    add(HomeGetTrendingTvShows());
  }
}
