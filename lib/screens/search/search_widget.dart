
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_db/screens/base/base.dart';
import 'package:movie_db/screens/base/base_state.dart';
import 'package:movie_db/screens/widgets/common_widgets.dart';
import 'package:movie_db/utils/logger/logger.dart';

import 'search_controller.dart';

class SearchWidget extends BaseStatefulWidget {
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends BaseState<SearchWidget, SearchController> {

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
                    child: controller.movies.isNotEmpty
                        ? buildSearchListWidget(controller.movies, context)
                        : buildEmptyListLayoutWidget(context)),
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
          controller.searchMovie(value.trim());
        });
  }

  @override
  SearchController getController() => SearchController(this, context);

  void showNetworkError(errDetailMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: null,
            content: Text(errDetailMessage),
            actions: [
              MaterialButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
