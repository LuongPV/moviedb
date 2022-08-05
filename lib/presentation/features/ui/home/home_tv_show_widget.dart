import 'package:flutter/material.dart';

import '../../data/models/trending_media.dart';
import '../../data/models/trending_media_type.dart';
import '../../data/repositories/trending_repository.dart';
import '../base/base_stateless_widget.dart';
import '../detail/tv_show_detail.dart';
import '../widgets/common_widgets.dart';

class HomeTVShowWidget extends BaseStatelessWidget {
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
    _trendingRepository.getTrendingMedia(TrendingMediaType.tvShow).then((response) {
      setState(() {
        trendingMovies = response.results;
      });
    });
  }
}
