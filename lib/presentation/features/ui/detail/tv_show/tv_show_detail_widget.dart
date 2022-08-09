import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../data/constants.dart';
import '../../../../../domain/models/cast.dart';
import '../../../../../domain/models/tv_show_detail.dart';
import '../../../../utils/logger/logger.dart';
import '../../base/base_stateful_widget.dart';
import '../../cast/cast_detail_widget.dart';
import '../../movie_by/movie_by_genre/movie_by_genre_widget.dart';
import 'tv_show_detail_bloc.dart';
import 'tv_show_detail_states.dart';

class TvShowDetailWidget extends BaseStatefulWidget {
  final int tvShowId;
  final String tvShowTitle;

  const TvShowDetailWidget({
    Key? key,
    required this.tvShowId,
    required this.tvShowTitle,
  }) : super(key: key);

  @override
  _TvShowDetailWidgetState createState() => _TvShowDetailWidgetState();
}

class _TvShowDetailWidgetState extends State<TvShowDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TvShowDetailBloc(
        RepositoryProvider.of(context),
        RepositoryProvider.of(context),
        widget.tvShowId,
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.tvShowTitle),
          ),
          body: BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
            builder: ((context, state) {
              return state is TvShowDetailLoaded
                  ? _buildDataContent(context)
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

  Widget _buildDataContent(BuildContext context) {
    return BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
        builder: (context, state) {
      if (state is TvShowDetailLoaded) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePosterWidget(state.tvShow.backdropPath),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.yellow,
                child: _buildInfoBannerWidget(state.tvShow),
              ),
              const SizedBox(height: 10),
              _buildYoutubeSearchButtonWidget(state.tvShow),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(state.tvShow.overview),
              ),
              _buildCastListWidget(),
            ],
          ),
        );
      }
      return Container();
    });
  }

  Container _buildYoutubeSearchButtonWidget(TvShowDetail tvShowDetail) {
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
        onPressed: () => _openYoutubeSearch(tvShowDetail.name),
      ),
    );
  }

  Column _buildInfoBannerWidget(TvShowDetail tvShowDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          tvShowDetail.name,
          style: const TextStyle(
            fontSize: 26,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(tvShowDetail.lastAirDate ?? '---',
            style: const TextStyle(color: Colors.black54)),
        SmoothStarRating(
            starCount: 5,
            rating: tvShowDetail.voteAverage.toDouble() / 2,
            allowHalfRating: true,
            size: 25,
            isReadOnly: true,
            color: Colors.blue,
            spacing: 0),
        _buildGenreListWidget(tvShowDetail),
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

  _openYoutubeSearch(String title) async {
    if (Platform.isAndroid) {
      final url = sprintf(urlYoutubeSearch, [title]);
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        Logger.w('Fail launch url $url');
      }
    }
  }

  Widget _buildGenreListWidget(TvShowDetail tvShowDetail) {
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
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieByGenreWidget(genre.id, genre.name))),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCastListWidget() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
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
                            Text(
                              '${cast.name} (${cast.character})',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CastDetailWidget(cast.id!))),
                    ),
                  )
                  .toList(),
            );
          }
          return Container();
        }));
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
}
