import 'package:flutter/material.dart';

import '../../base/base_stateful_widget.dart';


class HomeTrendingsWidget extends BaseStatefulWidget {
  const HomeTrendingsWidget({Key? key}) : super(key: key);

  @override
  _HomeTrendWidgetState createState() => _HomeTrendWidgetState();
}

class _HomeTrendWidgetState extends State<HomeTrendingsWidget> {
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
