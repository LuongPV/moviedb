import '../../../../../domain/models/cast.dart';
import '../../../../../domain/models/tv_show_detail.dart';

abstract class TvShowDetailState {}

class TvShowDetailInitial extends TvShowDetailState {}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowDetailLoaded extends TvShowDetailState {
  TvShowDetail tvShow;
  TvShowDetailLoaded(this.tvShow);
}

class TvShowDetailError extends TvShowDetailState {}

class CastsLoaded extends TvShowDetailState {
  List<Cast> casts;
  CastsLoaded(this.casts);
}
