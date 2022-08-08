abstract class SearchEvent {}

class SearchOpen extends SearchEvent {}

class RequestSearch extends SearchEvent {
  final String keyword;

  RequestSearch(this.keyword);
}
