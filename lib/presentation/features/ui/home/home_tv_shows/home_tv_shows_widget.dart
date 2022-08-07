import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/common_widgets.dart';
import '../../base/base_stateful_widget.dart';
import '../../detail/tv_show/tv_show_detail_widget.dart';
import 'home_tv_shows_bloc.dart';
import 'home_tv_shows_states.dart';

class HomeTVShowsWidget extends BaseStatefulWidget {
  const HomeTVShowsWidget({Key? key}) : super(key: key);

  @override
  _HomeTVShowWidgetState createState() => _HomeTVShowWidgetState();
}

class _HomeTVShowWidgetState extends State<HomeTVShowsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeTvShowsBloc(RepositoryProvider.of(context)),
      child: Builder(builder: (context) {
        return BlocBuilder<HomeTvShowsBloc, HomeTvShowsState>(
            builder: (context, state) {
          if (state is HomeTvShowsLoaded) {
            return buildMovieList(
              state.tvShows,
              context,
              itemClickListener: (item) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TvShowDetailWidget(
                      tvShowId: item.id!, tvShowTitle: item.name!),
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
