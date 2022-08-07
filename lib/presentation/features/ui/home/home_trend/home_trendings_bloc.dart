import '../../../../../domain/models/trending_media.dart';
import '../../../../../domain/models/trending_media_type.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../shared_blocs/base/base_bloc.dart';
import 'home_settings_events.dart';
import 'home_settings_states.dart';

class HomeTrendingsBloc
    extends BaseBloc<HomeTrendingsEvent, HomeTrendingsState> {
  final TrendingRepository _trendingRepository;
  List<TrendingMedia> trendingMovies = [];

  HomeTrendingsBloc(this._trendingRepository) : super(HomeTrendingsInitial()) {
    processEvent<HomeTrendingsGetMovies>((event, emit) async {
      emit(HomeTrendingsLoading());
      final response =
          await _trendingRepository.getTrendingMedia(TrendingMediaType.movie);
      trendingMovies = response.results;
      emit(HomeTrendingsLoaded(trendingMovies));
    });
    add(HomeTrendingsGetMovies());
  }
}
