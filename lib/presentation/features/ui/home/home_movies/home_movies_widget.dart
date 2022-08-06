import 'package:flutter/material.dart';

import '../../base/base_stateful_widget.dart';

class HomeMoviesWidget extends BaseStatefulWidget {
  const HomeMoviesWidget({Key? key}) : super(key: key);

  @override
  _HomeMovieWidgetState createState() => _HomeMovieWidgetState();
}

class _HomeMovieWidgetState extends State<HomeMoviesWidget> {
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
    _trendingRepository.getTrendingMedia(TrendingMediaType.movie).then((response) {
      setState(() {
        trendingMovies = response.results;
      });
    });
  }
}
