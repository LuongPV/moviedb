import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_db/data/constants.dart';
import 'package:movie_db/data/models/search_movie.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';


class MovieDetailWidget extends StatelessWidget {
  final Movie movie;

  MovieDetailWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getImagePosterWidget(movie.backdropPath),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20),
            color: Colors.yellow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title == movie.originalTitle ? movie.title : '${movie.title} (${movie.originalTitle})',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  movie.releaseDate ?? '---',
                  style: TextStyle(
                    color: Colors.black54
                  )
                ),
                SmoothStarRating(
                  starCount: 5,
                  rating: movie.voteAverage.toDouble() / 2,
                  allowHalfRating: true,
                  size: 25,
                  isReadOnly: true,
                  color: Colors.blue,
                  spacing: 0
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
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
                    Icon(
                      Icons.play_circle_outline
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'Youtube Search',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              onPressed: () => _openYoutubeSearch(movie.title),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(movie.overview),
          ),
        ],
      ),
    );
  }

  Widget _getImagePosterWidget(String imageName) {
    if (imageName == null) {
      return Image.asset(
        'assets/images/ic_movie_poster.jpg',
        height: 230,
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

}
