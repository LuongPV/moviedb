import 'package:flutter/material.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base_stateful_widget.dart';
import 'package:movie_db/screens/widgets/common_widgets.dart';

class MovieByCastWidget extends BaseStatefulWidget {
  final int castId;
  final String castName;

  MovieByCastWidget(this.castId, this.castName);

  @override
  _MovieByCastWidgetState createState() => _MovieByCastWidgetState();
}

class _MovieByCastWidgetState extends State<MovieByCastWidget> {
  var movies = List<MovieGeneral>();
  final _movieRepository = MovieRepository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _movieRepository.getMovieByCast(widget.castId).then((response) {
        setState(() {
          movies = response.cast;
        });
        widget.hideLoadingDialog(context);
      });
      widget.showLoadingDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.castName,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: movies.isNotEmpty
            ? buildSearchListWidget(movies, context)
            : buildEmptyListLayoutWidget(context),
      ),
    );
  }
}
