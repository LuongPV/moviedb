class DirectionResponse {
  List<Routes>? routes;

  DirectionResponse({this.routes});
}

class Routes {
  OverviewPolyline? overviewPolyline;

  Routes({this.overviewPolyline});
}

class OverviewPolyline {
  String? points;

  OverviewPolyline({this.points});

}
