import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../widgets/common_widgets.dart';
import '../../base/base_stateful_widget.dart';
import 'movie_by_genre_bloc.dart';
import 'movie_by_genre_states.dart';

class MovieByGenreWidget extends BaseStatefulWidget {
  final int _genreId;
  final String _genreName;

  const MovieByGenreWidget(this._genreId, this._genreName, {Key? key})
      : super(key: key);

  @override
  _MovieByGenreWidgetState createState() => _MovieByGenreWidgetState();
}

class _MovieByGenreWidgetState extends State<MovieByGenreWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieByGenreBloc(RepositoryProvider.of(context), widget._genreId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.txtGenre + widget._genreName,
          ),
        ),
        body: Builder(builder: (context) {
          return BlocBuilder<MovieByGenreBloc, MovieByGenreState>(
              builder: (context, state) {
            if (state is MovieByGenreLoaded) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: state.movies.isNotEmpty
                    ? buildSearchListWidget(state.movies, context)
                    : buildEmptyListLayoutWidget(context),
              );
            }
            return Container();
          });
        }),
      ),
    );
  }
}
