import 'package:flutter/material.dart';

import '../../data/models/movie_general.dart';
import '../../data/models/trending_media.dart';
import '../../data/models/trending_media_type.dart';
import '../../utils/logger/logger.dart';

Widget buildSearchListWidget(List<MovieGeneral> movies, BuildContext context) =>
    ListView(
      children:
          movies.map((movie) => _buildMovieItemWidget(movie, context)).toList(),
    );

Widget buildEmptyListLayoutWidget(BuildContext context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/ic_no_result.png',
            color: Colors.blue,
            width: 150,
          ),
          SizedBox(
            height: 30,
          ),
          Text(AppLocalizations.of(context).txtNoResult,
              style: TextStyle(color: Colors.blue, fontSize: 20))
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
            SizedBox(
              width: 10,
            ),
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
                  SizedBox(
                    height: 5,
                  ),
                  Text(movie.releaseDate ?? '---',
                      style: TextStyle(color: Colors.grey, fontSize: 16))
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => _openDetailMovie(movie, context));
}

void _openDetailMovie(MovieGeneral movie, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        Logger.d('Open movie $movie');
        return MovieDetailWidget(movie.id, movie.title);
      },
    ),
  );
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

Widget buildMovieList(
    List<TrendingMedia> movies,
    BuildContext context,
    {Function(TrendingMedia) itemClickListener, bool showType = false}
    ) {
  if (movies == null) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  return GridView.count(
    childAspectRatio: 0.5,
    padding: const EdgeInsets.all(10),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 3,
    children: movies
        .map((movie) => _buildMovieItem(movie, context, itemClickListener: itemClickListener, showType: showType))
        .toList(),
  );
}

Widget _buildMovieItem(TrendingMedia movie, BuildContext context, {Function(TrendingMedia) itemClickListener, bool showType = false}) {
  Widget content = Column(
    children: [
      _buildMovieImage(movie),
      Text(
        movie.title ?? movie.name,
        textAlign: TextAlign.center,
      )
    ],
  );
  if (showType) {
    content = Stack(
      children: [
        content,
        Positioned(
          top: 5,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            padding: EdgeInsets.all(3),
            child: _buildMediaTypeIcon(movie),
          ),
        ),
      ],
    );
  }

  return InkWell(
    child: content,
    onTap: () {
      if (itemClickListener != null) {
        itemClickListener(movie);
      }
    },
  );
}

Widget _buildMediaTypeIcon(TrendingMedia media) {
  var icon;
  if (media.mediaType == TrendingMediaType.movie.name) {
    icon = Icon(Icons.movie);
  } else if (media.mediaType == TrendingMediaType.tvShow.name) {
    icon = Icon(Icons.live_tv);
  } else {
    icon = Material();
  }
  return icon;
}

Widget _buildMovieImage(TrendingMedia movie) {
  if (movie.posterPath == null) {
    return Image.asset(
      'assets/images/ic_movie_thumbnail.png',
    );
  }
  return Image.network(
    movie.posterPath,
    height: 170,
  );
}
