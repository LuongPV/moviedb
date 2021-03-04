import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/models/trending_media.dart';
import 'package:movie_db/data/models/trending_media_type.dart';
import 'package:movie_db/data/repositories/trending_repository.dart';
import 'package:movie_db/screens/base/base_stateful_widget.dart';
import 'package:movie_db/screens/detail/tv_show_detail.dart';
import 'package:movie_db/screens/widgets/common_widgets.dart';

class HomeTVShowWidget extends BaseStatefulWidget {
  @override
  _HomeTVShowWidgetState createState() => _HomeTVShowWidgetState();
}

class _HomeTVShowWidgetState extends State<HomeTVShowWidget> {
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
    _trendingRepository.getTrendingMedia(TrendingMediaType.TV_SHOW).then((response) {
      setState(() {
        trendingMovies = response.results;
      });
    });
  }
}
