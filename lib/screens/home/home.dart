
import 'package:flutter/material.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/detail/movie_detail.dart';
import 'package:movie_db/utils/logger/logger.dart';

import '../../data/models/movie_search.dart';

class HomeWidget extends BaseStatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final movies = List<MovieGeneral>();
  final _movieRepository = MovieRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTextInputWidget(context),
              SizedBox(height: 20),
              Text(
                'Results:',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10,),
              Expanded(child: movies.isNotEmpty ? getSearchListWidget() : getEmptyListLayout()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextInputWidget(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(gapPadding: 0),
          hintText: 'Enter movie name',
        ),
        onSubmitted: (value) {
          Logger.d('Submit button click data = $value');
          _submitSearch(value.trim(), context);
        });
  }

  void _submitSearch(String searchText, BuildContext context) {
    _movieRepository.searchMovie(searchText).then((response) {
      setState(() {
        movies.clear();
        movies.addAll(response.results);
      });
      widget.hideLoadingDialog(context);
    });
    widget.showLoadingDialog(context);
  }

  Widget getSearchListWidget() => ListView(
        children: movies
            .map((movie) => getMovieItemWidget(movie))
            .toList(),
      );

  Widget getEmptyListLayout() => Center(
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

  Widget getMovieItemWidget(MovieGeneral movie) {
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
      onTap: () => _openDetailMovie(movie)
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

  void _openDetailMovie(MovieGeneral movie) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      Logger.d('Open movie $movie');
      return MovieDetailWidget(movie.id);
    }));
  }
}
