class DirectionResponse {
  List<Routes>? routes;

  DirectionResponse({this.routes});

  DirectionResponse.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = [];
      json['routes'].forEach((v) {
        routes?.add(new Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.routes != null) {
      data['routes'] = this.routes?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  OverviewPolyline? overviewPolyline;

  Routes({this.overviewPolyline});

  Routes.fromJson(Map<String, dynamic> json) {
    overviewPolyline = json['overview_polyline'] != null
        ? new OverviewPolyline.fromJson(json['overview_polyline'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overviewPolyline != null) {
      data['overview_polyline'] = this.overviewPolyline?.toJson();
    }
    return data;
  }
}

class OverviewPolyline {
  String? points;

  OverviewPolyline({this.points});

  OverviewPolyline.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    return data;
  }
}
