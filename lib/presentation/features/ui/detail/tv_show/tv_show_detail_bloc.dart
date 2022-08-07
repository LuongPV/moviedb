import '../../../../../domain/repositories/cast_repository.dart';
import '../../../../../domain/repositories/tv_show_repository.dart';
import '../../../shared_blocs/base/base_bloc.dart';
import 'tv_show_detail_events.dart';
import 'tv_show_detail_states.dart';

class TvShowDetailBloc extends BaseBloc<TvShowDetailEvent, TvShowDetailState> {
  final TvShowRepository _tvShowRepository;
  final CastRepository _castRepository;
  final int _tvShowId;

  TvShowDetailBloc(this._tvShowRepository, this._castRepository, this._tvShowId)
      : super(TvShowDetailInitial()) {
    processEvent<GetTvShowDetail>((event, emit) async {
      emit(TvShowDetailLoading());
      try {
        final response = await _tvShowRepository.getTvShowDetail(_tvShowId);
        emit(TvShowDetailLoaded(response));
      } catch (e) {
        emit(TvShowDetailError());
      }
    });
    processEvent<GetCasts>((event, emit) async {
      final response = await _castRepository.getCastByTVShow(_tvShowId);
      emit(CastsLoaded(response));
    });
    add(GetTvShowDetail());
    add(GetCasts());
  }
}
