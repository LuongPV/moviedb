import 'package:flutter/cupertino.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/data/models/trending_media.dart';
import 'package:movie_db/data/models/trending_media_type.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/widgets/common_widgets.dart';
import 'package:movie_db/utils/logger/logger.dart';

class HomeMovieWidget extends BaseStatefulWidget {
  @override
  _HomeMovieWidgetState createState() => _HomeMovieWidgetState();
}

class _HomeMovieWidgetState extends State<HomeMovieWidget> {
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
    var movies;
    if (trendingMovies == null) {
      movies = <MovieGeneral>[];
    } else {
      movies = trendingMovies.map((trendingMovie) => MovieGeneral(
        id: trendingMovie.id,
        backdropPath: trendingMovie.backdropPath,
        posterPath: trendingMovie.posterPath,
        title: trendingMovie.title,
        overview: trendingMovie.overview,
        voteCount: trendingMovie.voteCount,
        releaseDate: trendingMovie.releaseDate,
      )).toList();
    }

    return buildMovieList(movies, context);
  }

  void _getTrendingMovies() {
    _movieRepository.getTrendingMedia(TrendingMediaType.MOVIE).then((response) {
      setState(() {
        trendingMovies = response.results;
      });
      widget.hideLoadingDialog(context);
    });
    widget.showLoadingDialog(context);
  }
}
