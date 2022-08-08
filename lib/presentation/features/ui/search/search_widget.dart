import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../domain/models/movie_general.dart';
import '../../../utils/logger/logger.dart';
import '../../../widgets/common_widgets.dart';
import '../base/base_stateful_widget.dart';
import 'search_bloc.dart';
import 'search_events.dart';
import 'search_states.dart';

class SearchWidget extends BaseStatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(RepositoryProvider.of(context)),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextInputWidget(context),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.txtResult,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                      if (state is SearchMoviesLoaded) {
                        return _buildSearchWidget(state.movies);
                      }
                      return Container();
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSearchWidget(List<MovieGeneral> movies) {
    if (textController.text.isEmpty) {
      return Container();
    } else if (movies.isNotEmpty) {
      return buildSearchListWidget(movies, context);
    } else {
      return buildEmptyListLayoutWidget(context);
    }
  }

  Widget _buildTextInputWidget(BuildContext context) {
    return TextField(
        controller: textController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(gapPadding: 0),
          hintText: AppLocalizations.of(context)!.hintSearch,
        ),
        onSubmitted: (value) {
          Logger.d('Submit button click data = $value');
          BlocProvider.of<SearchBloc>(context).add(RequestSearch(value.trim()));
        });
  }

  void showLoading() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Loading, please wait...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 60),
      ),
    );
  }

  void hideLoading() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
