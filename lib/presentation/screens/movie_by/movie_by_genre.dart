import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/models/movie_general.dart';
import '../../data/repositories/movie_repository.dart';
import '../base/base_stateful_widget.dart';
import '../widgets/common_widgets.dart';

class MovieByGenreWidget extends BaseStatefulWidget {
  final int genreId;
  final String genreName;

  MovieByGenreWidget(this.genreId, this.genreName);

  @override
  _MovieByGenreWidgetState createState() => _MovieByGenreWidgetState();
}

class _MovieByGenreWidgetState extends State<MovieByGenreWidget> {
  var movies = List<MovieGeneral>();
  final _movieRepository = MovieRepository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _movieRepository.getMovieByGenre(widget.genreId).then((response) {
        setState(() {
          movies = response.results;
        });
        widget.hideLoadingDialog(context);
      });
      widget.showLoadingDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).txtGenre + widget.genreName,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: movies.isNotEmpty
            ? buildSearchListWidget(movies, context)
            : buildEmptyListLayoutWidget(context),
      ),
    );
  }
}
