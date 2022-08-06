import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/repositories/trending_repository.dart';
import '../../../../widgets/common_widgets.dart';
import '../../base/base_stateful_widget.dart';
import '../../detail/movie_detail.dart';
import 'home_movies_bloc.dart';
import 'home_movies_states.dart';

class HomeMoviesWidget extends BaseStatefulWidget {
  const HomeMoviesWidget({Key? key}) : super(key: key);

  @override
  _HomeMovieWidgetState createState() => _HomeMovieWidgetState();
}

class _HomeMovieWidgetState extends State<HomeMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeMoviesBloc(RepositoryProvider.of<TrendingRepository>(context)),
      child: Builder(builder: (context) {
        return BlocBuilder<HomeMoviesBloc, HomeMoviesStates>(
            builder: (context, state) {
          if (state is HomeMoviesTrendingLoaded) {
            return buildMovieList(
              state.trendingMovies,
              context,
              itemClickListener: (item) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailWidget(item.id, item.title),
                ),
              ),
            );
          }
          return Container();
        });
      }),
    );
  }
}
