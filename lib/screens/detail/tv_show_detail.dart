import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_db/data/constants.dart';
import 'package:movie_db/data/models/cast.dart';
import 'package:movie_db/data/models/tv_show_detail.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/cast/cast_detail.dart';
import 'package:movie_db/screens/movie_by/movie_by_genre.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

class TVShowDetailWidget extends BaseStatefulWidget {
  final int tvShowId;
  final String name;

  TVShowDetailWidget(this.tvShowId, this.name);

  @override
  _TVShowDetailWidgetState createState() => _TVShowDetailWidgetState();
}

class _TVShowDetailWidgetState extends State<TVShowDetailWidget> {
  TVShowDetail tvShowDetail;
  List<Cast> casts;
  final _movieRepository = MovieRepository();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getTVShowDetail(widget.tvShowId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: tvShowDetail == null ? _buildNoDataContent() : _buildDataContent(),
    );
  }

  Widget _buildNoDataContent() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  SingleChildScrollView _buildDataContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImagePosterWidget(tvShowDetail.backdropPath),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.yellow,
            child: _buildInfoBannerWidget(),
          ),
          SizedBox(height: 10),
          _buildYoutubeSearchButtonWidget(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(tvShowDetail.overview),
          ),
          _buildCastListWidget(),
        ],
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
        onPressed: () => _openYoutubeSearch(tvShowDetail.name),
      ),
    );
  }

  Column _buildInfoBannerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          tvShowDetail.name,
          style: TextStyle(
              fontSize: 26, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        Text(tvShowDetail.lastAirDate ?? '---',
            style: TextStyle(color: Colors.black54)),
        SmoothStarRating(
            starCount: 5,
            rating: tvShowDetail.voteAverage.toDouble() / 2,
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
      final url = sprintf(URL_YOUTUBE_SEARCH, [title]);
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        Logger.w('Fail launch url $url');
      }
    }
  }

  void _getTVShowDetail(int tvShowId) {
    _movieRepository.getTVShowDetail(tvShowId).then((response) {
      setState(() {
        tvShowDetail = response;
      });
    }).then((_) {
      _movieRepository.getCastByTVShow(tvShowId).then((response) {
        setState(() {
          casts = response.cast;
        });
      });
    });
  }

  Widget _buildGenreListWidget() {
    final random = Random();
    return Wrap(
      spacing: 4,
      children: tvShowDetail.genres
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
                (cast) => InkWell(
                  child: Container(
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
}
