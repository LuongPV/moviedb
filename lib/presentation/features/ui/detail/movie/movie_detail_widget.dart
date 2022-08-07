import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moviedb/presentation/features/ui/detail/movie/movie_detail_states.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../data/constants.dart';
import '../../../../../domain/models/cast.dart';
import '../../../../../domain/models/movie_detail.dart';
import '../../base/base_stateful_widget.dart';
import '../../cast/cast_detail.dart';
import '../../movie_by/movie_by_genre.dart';
import 'movie_detail_bloc.dart';
import 'movie_detail_events.dart';

class MovieDetailWidget extends BaseStatefulWidget {
  final int movieId;
  final String movieTitle;

  const MovieDetailWidget({
    Key? key,
    required this.movieId,
    required this.movieTitle,
  }) : super(key: key);

  @override
  MovieDetailWidgetState createState() => MovieDetailWidgetState();
}

class MovieDetailWidgetState extends State<MovieDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => MovieDetailBloc(
            RepositoryProvider.of(context),
            RepositoryProvider.of(context),
            RepositoryProvider.of(context),
            widget.movieId,
          )),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.movieTitle),
          ),
          body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: ((context, state) {
              return state is MovieDetailLoaded
                  ? _buildDataContent(context, state.movie)
                  : _buildNoDataContent();
            }),
          ),
        );
      }),
    );
  }

  Widget _buildNoDataContent() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildDataContent(BuildContext context, MovieDetail movieDetail) {
    return RefreshIndicator(
      onRefresh: () async =>
          BlocProvider.of<MovieDetailBloc>(context).add(GetMovieDetail()),
      strokeWidth: 5,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImagePosterWidget(movieDetail.backdropPath),
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.yellow,
              child: _buildInfoBannerWidget(movieDetail),
            ),
            const SizedBox(height: 10),
            _buildYoutubeVideos(context),
            _buildYoutubeSearchButtonWidget(movieDetail),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(movieDetail.overview ?? ''),
            ),
            _buildCastListWidget(context),
          ],
        ),
      ),
    );
  }

  Container _buildYoutubeSearchButtonWidget(MovieDetail movieDetail) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.red,
      ),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: MaterialButton(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_circle_outline),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.txtYoutubeSearch,
              textAlign: TextAlign.start,
            ),
          ],
        ),
        onPressed: () => launchUrl(
            Uri.parse(sprintf(urlYoutubeSearch, [movieDetail.title]))),
      ),
    );
  }

  Column _buildInfoBannerWidget(MovieDetail movieDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          movieDetail.title == movieDetail.originalTitle
              ? movieDetail.title!
              : '${movieDetail.title} (${movieDetail.originalTitle})',
          style: const TextStyle(
            fontSize: 26,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(movieDetail.releaseDate ?? '---',
            style: const TextStyle(color: Colors.black54)),
        SmoothStarRating(
            starCount: 5,
            rating: (movieDetail.voteAverage ?? 0).toDouble() / 2,
            allowHalfRating: true,
            size: 25,
            isReadOnly: true,
            color: Colors.blue,
            spacing: 0),
        _buildGenreListWidget(movieDetail),
      ],
    );
  }

  Widget _buildImagePosterWidget(String? imageName) {
    if (imageName == null) {
      return SizedBox(
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

  Widget _buildGenreListWidget(MovieDetail movieDetail) {
    final random = Random();
    return Wrap(
      spacing: 4,
      children: movieDetail.genres
          .map(
            (genre) => InkWell(
              child: Chip(
                label: Text(genre.name ?? ''),
                backgroundColor: Colors.white,
                avatar: CircleAvatar(
                  backgroundColor: Color.fromRGBO(random.nextInt(255),
                      random.nextInt(255), random.nextInt(255), 1),
                  child: Text(
                    genre.name![0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieByGenreWidget(genre.id!, genre.name!))),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCastListWidget(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state is CastsLoaded) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.casts
                .map(
                  (cast) => InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 100,
                      child: Column(
                        children: [
                          _buildCastImage(cast),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              '${cast.name} (${cast.character})',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CastDetailWidget(cast.id!))),
                  ),
                )
                .toList(),
          );
        }
        return Container();
      }),
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
      cast.profilePath!,
      width: 100,
      height: 150,
    );
  }

  Image _buildVideoImage(String path) {
    return Image.network(
      path,
    );
  }

  Widget _buildYoutubeVideos(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state is YoutubeVideosByMovieLoaded) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.youtubeVideos
                .map(
                  (youtubeVideo) => InkWell(
                    child: Stack(children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: 200,
                        child: Column(
                          children: [
                            _buildVideoImage(
                                youtubeVideo.snippet!.thumbnails.standard.url),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                youtubeVideo.snippet!.title,
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
                    ]),
                    onTap: () => launchUrl(Uri.parse(
                        sprintf(urlYoutubeViewVideo, [youtubeVideo.id]))),
                  ),
                )
                .toList(),
          );
        }
        return Container();
      }),
    );
  }
}
