import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/models/trending_media.dart';
import 'package:movie_db/data/models/trending_media_type.dart';
import 'package:movie_db/data/repositories/trending_repository.dart';
import 'package:movie_db/screens/base/base_stateful_widget.dart';
import 'package:movie_db/screens/detail/movie_detail.dart';
import 'package:movie_db/screens/widgets/common_widgets.dart';

class HomeMovieWidget extends BaseStatefulWidget {
  @override
  _HomeMovieWidgetState createState() => _HomeMovieWidgetState();
}

class _HomeMovieWidgetState extends State<HomeMovieWidget> {
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
          builder: (context) => MovieDetailWidget(item.id, item.title),
        ),
      ),
    );
  }

  void _getTrendingMovies() {
    _trendingRepository.getTrendingMedia(TrendingMediaType.MOVIE).then((response) {
      setState(() {
        trendingMovies = response.results;
      });
    });
  }
}
