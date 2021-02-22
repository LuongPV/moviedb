import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/screens/detail/movie_detail.dart';
import 'package:movie_db/utils/logger/logger.dart';

Widget buildSearchListWidget(List<MovieGeneral> movies, BuildContext context) => ListView(
  children: movies
      .map((movie) => _buildMovieItemWidget(movie, context))
      .toList(),
);

Widget buildEmptyListLayoutWidget() => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        'assets/images/ic_no_result.png',
        width: 150,
      ),
      SizedBox(
        height: 10,
      ),
      Text('No movies found',
          style: TextStyle(color: Colors.grey, fontSize: 20))
    ],
  ),
);

Widget _buildMovieItemWidget(MovieGeneral movie, BuildContext context) {
  return InkWell(
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            _getMovieThumbnailWidget(movie),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                      movie.releaseDate ?? '---',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => _openDetailMovie(movie, context)
  );
}

void _openDetailMovie(MovieGeneral movie, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    Logger.d('Open movie $movie');
    return MovieDetailWidget(movie.id);
  }));
}

Widget _getMovieThumbnailWidget(MovieGeneral movie) {
  if (movie.posterPath == null) {
    return Image.asset(
      'assets/images/ic_movie_thumbnail.png',
      width: 80,
      height: 120,
    );
  }
  return Image.network(
    movie.posterPath,
    width: 80,
    height: 120,
  );
}