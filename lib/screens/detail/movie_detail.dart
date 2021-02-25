import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_db/data/constants.dart';
import 'package:movie_db/data/models/cast.dart';
import 'package:movie_db/data/models/movie_detail.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/movie_by_genre/movie_by_genre.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieDetailWidget extends BaseStatefulWidget {

  @override
  _MovieDetailWidgetState createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  MovieDetail movie;
  List<Cast> casts;
  final _movieRepository = MovieRepository();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final movieId = ModalRoute.of(context).settings.arguments;
      Logger.d('Movie ID = $movieId');
      _getMovieDetail(movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (movie == null) {
      return Scaffold();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImagePosterWidget(movie.backdropPath),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.yellow,
              child: _buildInfoBannerWidget(),
            ),
            SizedBox(height: 10),
            _buildYoutubeSearchButtonWidget(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(movie.overview),
            ),
            _buildCastListWidget(),
          ],
        ),
      ),
    );
  }

  Container _buildYoutubeSearchButtonWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.red,
      ),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: MaterialButton(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_circle_outline),
            SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizations.of(context).txtYoutubeSearch,
              textAlign: TextAlign.start,
            ),
          ],
        ),
        onPressed: () => _openYoutubeSearch(movie.title),
      ),
    );
  }

  Column _buildInfoBannerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          movie.title == movie.originalTitle
              ? movie.title
              : '${movie.title} (${movie.originalTitle})',
          style: TextStyle(
              fontSize: 26, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        Text(movie.releaseDate ?? '---',
            style: TextStyle(color: Colors.black54)),
        SmoothStarRating(
            starCount: 5,
            rating: movie.voteAverage.toDouble() / 2,
            allowHalfRating: true,
            size: 25,
            isReadOnly: true,
            color: Colors.blue,
            spacing: 0),
        _buildGenreListWidget(),
      ],
    );
  }

  Widget _buildImagePosterWidget(String imageName) {
    if (imageName == null) {
      return Container(
        height: 230,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/ic_movie_thumbnail.png',
            height: 120,
          ),
        ),
      );
    }
    return Image.network(imageName);
  }

  _openYoutubeSearch(String title) async {
    if (Platform.isAndroid) {
      final url = BASE_URL_YOUTUBE_SEARCH + title;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        Logger.w('Fail launch url $url');
      }
    }
  }

  void _getMovieDetail(int movieId) {
    _movieRepository.getMovieDetail(movieId).then((response) {
      setState(() {
        movie = response;
      });
    }).then((_) {
      _movieRepository.getCastByMovie(movieId).then((response) {
        setState(() {
          casts = response.cast;
        });
        widget.hideLoadingDialog(context);
      });
    });
    widget.showLoadingDialog(context);
  }

  Widget _buildGenreListWidget() {
    final random = Random();
    return Wrap(
      spacing: 4,
      children: movie.genres
          .map(
            (genre) => InkWell(
              child: Chip(
                label: Text(genre.name),
                backgroundColor: Colors.white,
                avatar: CircleAvatar(
                  backgroundColor: Color.fromRGBO(random.nextInt(255),
                      random.nextInt(255), random.nextInt(255), 1),
                  child: Text(
                    genre.name[0],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MovieByGenreWidget(genre.id, genre.name))),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCastListWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: casts == null
            ? []
            : casts.map(
                (cast) => Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 100,
                  child: Column(
                    children: [
                      _buildCastImage(cast),
                      Text(
                        '${cast.name} (${cast.character})',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ).toList(),
      ),
    );
  }

  Image _buildCastImage(Cast cast) {
    if (cast.profilePath == null) {
      return Image.asset(
        'assets/images/ic_cast_no_image.png',
        width: 100,
        height: 150,
        fit: BoxFit.cover,
      );
    }
    return Image.network(
      cast.profilePath,
      width: 100,
      height: 150,
    );
  }
}
