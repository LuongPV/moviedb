import 'package:flutter/material.dart';

import '../../base/base_stateful_widget.dart';

class HomeTVShowsWidget extends BaseStatefulWidget {
  const HomeTVShowsWidget({Key? key}) : super(key: key);

  @override
  _HomeTVShowWidgetState createState() => _HomeTVShowWidgetState();
}

class _HomeTVShowWidgetState extends State<HomeTVShowsWidget> {
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
          builder: (context) => TVShowDetailWidget(item.id, item.name),
        ),
      ),
    );
  }

  void _getTrendingMovies() {
    _trendingRepository
        .getTrendingMedia(TrendingMediaType.tvShowDetail)
        .then((response) {
      setState(() {
        trendingMovies = response.results;
      });
    });
  }
}
