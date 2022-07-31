import 'package:flutter/material.dart';

import '../../data/models/trending_media.dart';
import '../../data/models/trending_media_type.dart';
import '../../data/repositories/trending_repository.dart';
import '../base/base_stateful_widget.dart';
import '../detail/movie_detail.dart';
import '../detail/tv_show_detail.dart';
import '../widgets/common_widgets.dart';

class HomeTrendWidget extends BaseStatefulWidget {
  @override
  _HomeTrendWidgetState createState() => _HomeTrendWidgetState();
}

class _HomeTrendWidgetState extends State<HomeTrendWidget> {
  List<TrendingMedia> trendingMovies;
  final _trendingRepository = TrendingRepository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getTrendingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildMovieList(
      trendingMovies,
      context,
      itemClickListener: (item) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (item.mediaType == TrendingMediaType.movie.name) {
              return MovieDetailWidget(item.id, item.title);
            } else {
              return TVShowDetailWidget(item.id, item.name);
            }
          },
        ),
      ),
      showType: true
    );
  }

  void _getTrendingMovies() {
    _trendingRepository.getTrendingMedia(TrendingMediaType.all).then((response) {
      setState(() {
        trendingMovies = response.results;
      });
    });
  }
}
