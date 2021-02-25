import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/data/constants.dart';
import 'package:movie_db/data/models/cast_detail.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/detail/movie_detail.dart';
import 'package:movie_db/screens/movie_by/movie_by_cast.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class CastDetailWidget extends BaseStatefulWidget {
  final int castId;

  CastDetailWidget(this.castId);

  @override
  _CastDetailWidgetState createState() => _CastDetailWidgetState();
}

class _CastDetailWidgetState extends State<CastDetailWidget> {
  CastDetail castDetail;
  List<MovieGeneral> movies;
  final _movieRepository = MovieRepository();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Logger.d('Cast ID = ${widget.castId}');
      _getCastDetail(widget.castId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (castDetail == null) {
      return Scaffold();
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.yellow,
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileImage(),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildCastName(),
                        _buildBirthday(),
                        _buildGender(),
                        _buildLocation(),
                        _buildImdb()
                      ],
                    ),
                  )
                ],
              ),
            ),
            _buildMovieBanner(),
            Expanded(child: _buildMovieList()),
          ],
        ),
      ),
    );
  }

  Container _buildMovieBanner() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.blue,
      child: Row(
        children: [
          Text(
            'Movies:',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          Expanded(child: Material()),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: MaterialButton(
              child: Text(
                'See Full',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieByCastWidget(
                          castDetail.id, "${castDetail.name}'s movies"))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Image.network(
      castDetail.profilePath,
      width: 150,
    );
  }

  Widget _buildImdb() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.only(top: 20),
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/ic_imdb.png',
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 5,
            ),
            Text('IMDB Info',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        onTap: () => _openCastImdbPage(),
      ),
    );
  }

  Widget _buildLocation() {
    return _buildTextInfo(
      'Location: ' + castDetail.placeOfBirth,
    );
  }

  Widget _buildGender() {
    var gender;
    if (castDetail.gender == 2) {
      gender = 'Male';
    } else if (castDetail.gender == 1) {
      gender = 'Female';
    } else {
      gender = 'Other';
    }
    return _buildTextInfo('Gender: ' + gender);
  }

  Widget _buildBirthday() {
    return _buildTextInfo('Birthday: ' + castDetail.birthday);
  }

  Widget _buildCastName() {
    return Text(castDetail.name,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
        ));
  }

  void _getCastDetail(int castId) {
    _movieRepository.getCastDetail(castId).then((response) {
      setState(() {
        castDetail = response;
      });
    }).then((_) {
      _movieRepository.getMovieByCast(widget.castId).then((response) {
        setState(() {
          movies = response.cast.take(6).toList();
        });
        widget.hideLoadingDialog(context);
      });
    });
    widget.showLoadingDialog(context);
  }

  Widget _buildTextInfo(String text) {
    return Container(
      child: Text(text),
      margin: EdgeInsets.only(top: 5),
    );
  }

  _openCastImdbPage() async {
    if (Platform.isAndroid) {
      final url = BASE_URL_IMDB_CAST + castDetail.imdbId;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        Logger.w('Fail launch url $url');
      }
    }
  }

  Widget _buildMovieList() {
    if (movies == null) {
      return Material();
    }
    return GridView.count(
      childAspectRatio: 0.5,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: movies.map(_buildMovieItem).toList(),
    );
  }

  Widget _buildMovieItem(MovieGeneral movie) {
    return InkWell(
        child: Column(
          children: [_buildMovieImage(movie), Text(movie.title)],
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailWidget(),
              settings: RouteSettings(
                arguments: movie.id,
              ),
            )));
  }

  Widget _buildMovieImage(MovieGeneral movie) {
    if (movie.posterPath == null) {
      return Image.asset(
        'assets/images/ic_movie_thumbnail.png',
      );
    }
    return Image.network(
      movie.posterPath,
    );
  }
}
