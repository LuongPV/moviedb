import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/models/trending_media.dart';
import 'package:movie_db/data/models/trending_media_type.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/detail/tv_show_detail.dart';
import 'package:movie_db/screens/widgets/common_widgets.dart';

class HomeTVShowWidget extends BaseStatefulWidget {
  @override
  _HomeTVShowWidgetState createState() => _HomeTVShowWidgetState();
}

class _HomeTVShowWidgetState extends State<HomeTVShowWidget> {
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
          builder: (context) => TVShowDetailWidget(item.id),
        ),
      ),
    );
  }

  void _getTrendingMovies() {
    _movieRepository.getTrendingMedia(TrendingMediaType.TV_SHOW).then((response) {
      setState(() {
        trendingMovies = response.results;
      });
      widget.hideLoadingDialog(context);
    });
    widget.showLoadingDialog(context);
  }
}
