import 'package:moviedb/presentation/features/shared_blocs/base/base_bloc.dart';
import 'package:moviedb/presentation/features/ui/home/home_movies/home_movies_events.dart';
import 'package:moviedb/presentation/features/ui/home/home_movies/home_movies_states.dart';

class HomeMoviesBloc extends BaseBloc<HomeMoviesEvents, HomeMoviesStates> {
  HomeMoviesBloc() : super(HomeMoviesInitial());
}
