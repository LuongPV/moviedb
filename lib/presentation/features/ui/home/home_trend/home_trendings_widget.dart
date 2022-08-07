import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/trending_media_type.dart';
import '../../../../widgets/common_widgets.dart';
import '../../base/base_stateful_widget.dart';
import '../../detail/movie/movie_detail_widget.dart';
import '../../detail/tv_show/tv_show_detail_widget.dart';
import 'home_settings_states.dart';
import 'home_trendings_bloc.dart';

class HomeTrendingsWidget extends BaseStatefulWidget {
  const HomeTrendingsWidget({Key? key}) : super(key: key);

  @override
  _HomeTrendWidgetState createState() => _HomeTrendWidgetState();
}

class _HomeTrendWidgetState extends State<HomeTrendingsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeTrendingsBloc(RepositoryProvider.of(context)),
      child: Builder(builder: (context) {
        return BlocBuilder<HomeTrendingsBloc, HomeTrendingsState>(
            builder: (context, state) {
          if (state is HomeTrendingsLoaded) {
            return buildMovieList(state.trendingMovies, context,
                itemClickListener: (item) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          if (item.mediaType == TrendingMediaType.movie.name) {
                            return MovieDetailWidget(movieId: item.id!, movieTitle: item.title!);
                          } else {
                            return TvShowDetailWidget(item.id, item.name);
                          }
                        },
                      ),
                    ),
                showType: true);
          }
          return Container();
        });
      }),
    );
  }
}
