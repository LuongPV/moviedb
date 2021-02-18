import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_db/screens/detail/movie_detail.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../data/models/search.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final movies = List<Movie>();

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
    final query = 'https://api.themoviedb.org/3/search/movie?api_key=72ca6ce7e0d22478aca5df10518f5888&query=$searchText';
    final encodedQuery = Uri.encodeFull(query);
    Logger.d('encodedQuery = $encodedQuery');
    http.get(encodedQuery).then((Response response) {
      Logger.d('data = ${response.body}');
      if (response.statusCode == 200) {
        _processSearchData(response.body, context);
      }
    });
    showDialog(
      context: context,
      builder: (context) => _getDialog(),
    );
  }

  void _processSearchData(String jsonBody, BuildContext context) {
    final responseMapData = jsonDecode(jsonBody);
    try {
      final searchResponse = SearchResponse.fromJson(responseMapData);
      setState(() {
        movies.clear();
        movies.addAll(searchResponse.results);
      });
    } catch (e) {
      Logger.w('Parse search data fail detail = $e');
    } finally {
      Navigator.pop(context); // Dismiss dialog
    }
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

  Widget _getDialog() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            SizedBox(width: 20,),
            new Text("Loading"),
          ],
        ),
      ),
    );
  }

  Widget getMovieItemWidget(Movie movie) {
    return InkWell(
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Image.network(
              'http://image.tmdb.org/t/p/w500/${movie.posterPath}',
              width: 80,
            ),
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

  void _openDetailMovie(Movie movie) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      Logger.d('Open movie $movie');
      return MovieDetailWidget(movie);
    }));
  }
}
