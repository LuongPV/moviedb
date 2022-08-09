import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/common_widgets.dart';
import '../../base/base_stateful_widget.dart';
import 'movie_by_cast_bloc.dart';
import 'movie_by_cast_states.dart';

class MovieByCastWidget extends BaseStatefulWidget {
  final int castId;
  final String castName;

  const MovieByCastWidget(this.castId, this.castName, {Key? key})
      : super(key: key);

  @override
  _MovieByCastWidgetState createState() => _MovieByCastWidgetState();
}

class _MovieByCastWidgetState extends State<MovieByCastWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieByCastBloc(RepositoryProvider.of(context), widget.castId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.castName,
          ),
        ),
        body: Builder(builder: (context) {
          return BlocBuilder<MovieByCastBloc, MovieByCastState>(
              builder: (context, state) {
            if (state is MovieByCastLoaded) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: state.movies.isNotEmpty
                    ? buildSearchListWidget(state.movies, context)
                    : buildEmptyListLayoutWidget(context),
              );
            }
            return Container();
          });
        }),
      ),
    );
  }
}
