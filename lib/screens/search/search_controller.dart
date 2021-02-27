import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:async/async.dart';

import 'search_widget.dart';

class SearchController {
  SearchWidgetState state;
  BuildContext context;
  final movies = List<MovieGeneral>();
  final _movieRepository = MovieRepository();
  CancelableOperation _searchOperation;

  SearchController(this.state, this.context);

  void searchMovie(String searchText) {
    final apiFuture = _movieRepository.searchMovie(searchText).then((response) {
      state.updateUI(() {
        movies.clear();
        movies.addAll(response.results);
      });
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
