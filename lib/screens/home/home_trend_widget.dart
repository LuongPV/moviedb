import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/models/trending_media.dart';
import 'package:movie_db/data/models/trending_media_type.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/detail/movie_detail.dart';
import 'package:movie_db/screens/detail/tv_show_detail.dart';
import 'package:movie_db/screens/widgets/common_widgets.dart';

class HomeTrendWidget extends BaseStatefulWidget {
  @override
  _HomeTrendWidgetState createState() => _HomeTrendWidgetState();
}

class _HomeTrendWidgetState extends State<HomeTrendWidget> {
  List<TrendingMedia> trendingMovies;
  final _movieRepository = MovieRepository();

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
            if (item.mediaType == TrendingMediaType.MOVIE.name) {
              return MovieDetailWidget(item.id);
            } else {
              return TVShowDetailWidget(item.id);
            }
          },
        ),
      ),
      showType: true
    );
  }

  void _getTrendingMovies() {
    _movieRepository.getTrendingMedia(TrendingMediaType.ALL).then((response) {
      setState(() {
        trendingMovies = response.results;
      });
    });
  }
}
