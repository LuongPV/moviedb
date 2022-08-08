import '../../../../domain/repositories/cast_repository.dart';
import '../../../../domain/repositories/movie_repository.dart';
import '../../shared_blocs/base/base_bloc.dart';
import 'cast_detail_events.dart';
import 'cast_detail_states.dart';

class CastDetailBloc extends BaseBloc<CastDetailEvent, CastDetailState> {
  final MovieRepository _movieRepository;
  final CastRepository _castRepository;
  final int castId;

  CastDetailBloc(
    this._movieRepository,
    this._castRepository,
    this.castId,
  ) : super(CastDetailInitial()) {
    processEvent<LoadCastDetail>((event, emit) async {
      emit(CastDetailLoading());
      final castDetailResponse = await _castRepository.getCastDetail(castId);
      emit(CastDetailLoaded(castDetailResponse!));
    });
    processEvent<LoadMovieByCast>((event, emit) async {
      final movieByCastResponse = await _movieRepository.getMovieByCast(castId);
      emit(MovieByCastLoaded(movieByCastResponse.cast.take(6).toList()));
    });
    add(LoadCastDetail());
    add(LoadMovieByCast());
  }
}
