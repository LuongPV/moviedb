import 'package:flutter/material.dart';
import 'package:movie_db/data/models/movie_general.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/widgets/common_widgets.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              _buildTextInputWidget(context),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).txtResult,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: movies.isNotEmpty ? buildSearchListWidget(movies, context) : buildEmptyListLayoutWidget(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInputWidget(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(gapPadding: 0),
          hintText: AppLocalizations.of(context).hintSearch,
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
}
