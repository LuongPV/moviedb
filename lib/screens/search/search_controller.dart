import 'dart:io';

import 'package:async/async.dart';

import '../../data/models/movie_general.dart';
import '../../data/repositories/movie_repository.dart';
import '../base/base_stateful_controller.dart';
import 'search_widget.dart';

class SearchController extends BaseStatefulController<SearchWidgetState> {
  final movies = List<MovieGeneral>();
  final _movieRepository = MovieRepository();
  CancelableOperation _searchOperation;

  SearchController(state, context) : super(state, context);

  void searchMovie(String searchText) {
    final apiFuture = _movieRepository.searchMovie(searchText).then((response) {
      movies.clear();
      movies.addAll(response.results);
      updateUI();
      state.hideLoading();
    }).catchError((e) {
      state.hideLoading();
      var errDetailMessage;
      if (e is SocketException) {
        errDetailMessage = 'Please check the internet connection!';
      } else {
        errDetailMessage = "We're having technique issue, please try later!";
      }
      state.showNetworkError(errDetailMessage);
    });
    _searchOperation = CancelableOperation.fromFuture(apiFuture);
    state.showLoading();
  }

  void cancelSearch() {
    if (_searchOperation != null) {
      _searchOperation.cancel();
    }
  }
}
