import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';

import 'search_widget.dart';

class SearchController {
  SearchWidgetState state;
  BuildContext context;
  final movies = List<MovieGeneral>();
  final _movieRepository = MovieRepository();

  SearchController(this.state, this.context);

  void searchMovie(String searchText) {
    _movieRepository.searchMovie(searchText).then((response) {
      state.updateUI(() {
        movies.clear();
        movies.addAll(response.results);
      });
      state.widget.hideLoadingDialog(context);
    }).catchError((e) {
      state.widget.hideLoadingDialog(context);
      var errDetailMessage;
      if (e is SocketException) {
        errDetailMessage = 'Please check the internet connection!';
      } else {
        errDetailMessage = "We're having technique issue, please try later!";
      }
      state.showNetworkError(errDetailMessage);
    });
    state.widget.showLoadingDialog(context);
  }
}
