import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_db/data/constants.dart';
import 'package:movie_db/data/models/cast.dart';
import 'package:movie_db/screens/base/base_stateful_widget.dart';
import 'package:movie_db/screens/base/base_state.dart';
import 'package:movie_db/screens/cast/cast_detail.dart';
import 'package:movie_db/screens/detail/movie_detail_controller.dart';
import 'package:movie_db/screens/movie_by/movie_by_genre.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:movie_db/utils/url.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailWidget extends BaseStatefulWidget {
  final movieId;
  final title;

  MovieDetailWidget(this.movieId, this.title);

  @override
  MovieDetailWidgetState createState() => MovieDetailWidgetState();
}

class MovieDetailWidgetState extends BaseState<MovieDetailWidget, MovieDetailController> {

  @override
  getController() => MovieDetailController(this, context);

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getMovieDetail(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: controller.movie == null ? _buildNoDataContent() : _buildDataContent(),
    );
  }


  Widget _buildNoDataContent() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDataContent() {
    return RefreshIndicator(
      onRefresh: () => controller.refreshData(widget.movieId),
      strokeWidth: 5,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImagePosterWidget(controller.movie.backdropPath),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.yellow,
              child: _buildInfoBannerWidget(),
            ),
            SizedBox(height: 10),
            _buildTrailerVideos(),
            _buildYoutubeSearchButtonWidget(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(controller.movie.overview),
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
        onPressed: () => launchUrl(sprintf(URL_YOUTUBE_SEARCH, [controller.movie.title])),
      ),
    );
  }

  Column _buildInfoBannerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          controller.movie.title == controller.movie.originalTitle
              ? controller.movie.title
              : '${controller.movie.title} (${controller.movie.originalTitle})',
          style: TextStyle(
              fontSize: 26, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        Text(controller.movie.releaseDate ?? '---',
            style: TextStyle(color: Colors.black54)),
        SmoothStarRating(
            starCount: 5,
            rating: controller.movie.voteAverage.toDouble() / 2,
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

  Widget _buildGenreListWidget() {
    final random = Random();
    return Wrap(
      spacing: 4,
      children: controller.movie.genres
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
        children: controller.casts == null
            ? []
            : controller.casts.map(
                (cast) => InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 100,
                    child: Column(
                      children: [
                        _buildCastImage(cast),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            '${cast.name} (${cast.character})',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CastDetailWidget(cast.id))
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

  Image _buildVideoImage(String path) {
    return Image.network(
      path,
    );
  }

  Widget _buildTrailerVideos() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.trailerVideos
            .map(
              (trailerVideo) => InkWell(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: 200,
                      child: Column(
                        children: [
                          _buildVideoImage(trailerVideo.snippet.thumbnails.standard.url),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              trailerVideo.snippet.title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 90,
                      top: 30,
                      child: Image.asset(
                        'assets/images/ic_play_youtube.png',
                        height: 50,
                      ),
                    ),
                  ]
                ),
                onTap: () => launchUrl(sprintf(URL_YOUTUBE_VIEW_VIDEO, [trailerVideo.id])),
              ),
            )
            .toList(),
      ),
    );
  }
}
