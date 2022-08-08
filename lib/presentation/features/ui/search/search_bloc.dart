import '../../../../domain/repositories/movie_repository.dart';
import '../../shared_blocs/base/base_bloc.dart';
import 'search_events.dart';
import 'search_states.dart';

class SearchBloc extends BaseBloc<SearchEvent, SearchState> {
  final MovieRepository _movieRepository;

  SearchBloc(this._movieRepository) : super(SearchInitial()) {
    processEvent<RequestSearch>((event, emit) async {
      emit(SearchMoviesLoading());
      final response = await _movieRepository.searchMovie(event.keyword);
      emit(SearchMoviesLoaded(response.results));
    });
  }
}
